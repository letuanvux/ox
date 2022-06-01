import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../themes.dart';
import '../commons/app_background.dart';
import '../commons/app_logo.dart';
import '../../configs/routes.dart';
import '../commons/social_button.dart';
import 'components/email_input.dart';
import 'components/password_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: RichText(
              text: TextSpan(
                  text: "Login ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
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
          leading: BackButton(),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, VLTxRoutes.home);
                },
                icon: Icon(Icons.home)),
          ],
        ),
        body: Stack(
          children: [
            AppBackground(image: VLTxTheme.bgImage),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                  AppLogo(), 
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          EmailInput(controller: _emailController, hintText: 'Email', checkExisted: false),  
                          PasswordInput(controller: _passwordController, hintText: 'Password'),  
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, VLTxRoutes.verify);
                                },
                                child: Text(
                                  "Verify Email?",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, VLTxRoutes.forgot);
                              },
                              child: Text(
                                "Forgot Password?",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            ],
                          ),
                          
                          SizedBox(height: 10.0),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Theme.of(context).colorScheme.primary,
                                minimumSize: const Size.fromHeight(40), // NEW
                              ),
                              onPressed: signIn,
                              child: Text('Login')),
                          Divider(
                            height: 1,
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "or connect with",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoginFacebook(),
                              SizedBox(width: 10),
                              LoginGoogle(),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account. ",
                              ),
                              GestureDetector(
                                child: Text("Sign up?",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold)),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, VLTxRoutes.signup);
                                },
                              )
                            ]),
                            

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),            
          ],
        ));
  }

  Future signIn() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
                child: CircularProgressIndicator(),
              ));
      try {
        UserCredential user =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (user.user != null) {
          Navigator.pushNamed(context, VLTxRoutes.home);
        }
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }
}
