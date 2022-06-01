import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../configs/routes.dart';
import '../../services/user_service.dart';
import '../commons/app_background.dart';
import '../commons/app_logo.dart';
import '../home/home_page.dart';
import '../themes.dart';

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
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
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
      ? HomePage()
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
                    children: [
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  AppLogo(),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              'A verification email has been sent to your email',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.normal,
                              ),
                            ),                            
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't receive verify code? ",
                                  ),
                                  GestureDetector(
                                    child: Text("Resent email",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold)),
                                    onTap: canResendEmail ? sendVerificationEmail : null,
                                  )
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      Theme.of(context).colorScheme.primary,
                                  minimumSize: const Size.fromHeight(40), // NEW
                                ),
                                onPressed: canResendEmail ? sendVerificationEmail : null,
                                child: Text('Resent email')),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey[300],
                                  minimumSize: const Size.fromHeight(40), // NEW
                                ),
                                onPressed: () => FirebaseAuth.instance.signOut(),
                                child: Text('Cancel')),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
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
                                      Navigator.pushNamed(
                                          context, VLTxRoutes.login);
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
