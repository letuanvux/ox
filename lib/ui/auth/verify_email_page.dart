import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../vltx/vltx.dart';
import '../home/home_page.dart';
import '../themes.dart';
import 'services/user_service.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _activecodeController = TextEditingController();

  final userService = UserService();

  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);

    } catch (e) {
      print(e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    _emailController.dispose();
    _activecodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomePage()
      : Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: RichText(
                text: TextSpan(
                    text: "Verify ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    children: const [
                  TextSpan(
                    text: 'your email',
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  AppLogo(),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(20))),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const Text(
                              'A verification email has been sent to your email',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.normal,
                              ),
                            ),                            
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't receive verify code? ",
                                  ),
                                  GestureDetector(
                                    onTap: canResendEmail ? sendVerificationEmail : null,
                                    child: Text("Resent email",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ]),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      Theme.of(context).colorScheme.primary,
                                  minimumSize: const Size.fromHeight(40), // NEW
                                ),
                                onPressed: canResendEmail ? sendVerificationEmail : null,
                                child: const Text('Resent email')),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey[300],
                                  minimumSize: const Size.fromHeight(40), // NEW
                                ),
                                onPressed: () => FirebaseAuth.instance.signOut(),
                                child: const Text('Cancel')),
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
                    ),
                  )
                ],
              )
            ],
          ),
        );
}
