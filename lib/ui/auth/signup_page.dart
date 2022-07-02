import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../vltx/vltx.dart';
import '../themes.dart';
import 'components/email_input.dart';
import 'components/password_input.dart';
import 'services/user_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late bool hadEmail = false;
  final _formKey = GlobalKey<FormState>();
  final _displaynameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  final userService = UserService();

  @override
  void dispose() {
    _displaynameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: RichText(
              text: TextSpan(
                  text: "Register ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                  children: const [
                TextSpan(
                  text: 'your account?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ])),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Theme.of(context).colorScheme.primary.withOpacity(.24),
          leading: const BackButton(),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, VLTxRoutes.home);
                },
                icon: const Icon(Icons.home)),
          ],
        ),
        body: Stack(
          children: [
            const AppBackground(image: VLTxTheme.bgImage),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20))),
              child: Column(
                children: [
                  Expanded(child: AppLogo(),),
                  Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            EmailInput(
                              controller: _emailController,
                              hintText: 'Email',
                              checkExisted: true,
                            ),
                            PasswordInput(
                                controller: _passwordController,
                                hintText: 'Password'),
                            TextFormField(
                              controller: _displaynameController,
                              cursorColor: Colors.black,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              decoration:
                                  const InputDecoration(hintText: 'Display Name'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Required';
                                }
                                if (value.length < 6) {
                                  return 'Please enter display name with 6 or more characters';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _phoneController,
                              cursorColor: Colors.black,
                              textInputAction: TextInputAction.next,
                              keyboardType: const TextInputType.numberWithOptions(),
                              decoration:
                                  const InputDecoration(hintText: 'Phone number'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).colorScheme.primary,
                                  minimumSize: const Size.fromHeight(40), // NEW
                                ),
                                onPressed: signUp,
                                child: const Text('Sign up')),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "I'm already a member. ",
                                  ),
                                  GestureDetector(
                                    child: Text("Login?",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold)),
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //     context, VLTxRoutes.login);
                                    },
                                  )
                                ]),
                          ],
                        ),
                      ),

                ],
              ),
            ),            
          ],
        ));
  }

  bool isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  Future signUp() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ));
      try {        
        var existed = await userService.isExistedEmail(_emailController.text.trim());
        if (!existed)
        {
          UserCredential user =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          if (user.user != null) {
            userService.createUser(
                user.user!.uid,
                _displaynameController.text.trim(),
                _emailController.text.trim(),
                _phoneController.text.trim());
          }
          // Navigator.pushNamed(context, VLTxRoutes.verify);
        }
        else {
          // Navigator.pushNamed(context, VLTxRoutes.forgot);
        }
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }
}
