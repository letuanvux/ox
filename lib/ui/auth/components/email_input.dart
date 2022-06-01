import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool checkExisted;
  const EmailInput(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.checkExisted})
      : super(key: key);

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  bool _isCheckingEmail = false;
  dynamic _validationEmail;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.checkExisted
            ? _isCheckingEmail
                ? Transform.scale(
                    scale: 0.5, child: CircularProgressIndicator())
                : null
            : null,
      ),
      controller: widget.controller,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        if (!isEmailValid(value)) {
          return 'Enter a valid email address';
        }
        return _validationEmail;
      },
      //validator: (val) => _validationEmail,
      onChanged: (text) async {
        if (!_isCheckingEmail) await checkEmail(text);
      },
    );
  }

  Future<dynamic> checkEmail(email) async {
    //do all sync validation
    // if (email.isEmpty) {
    //   _validationEmail = "Required";
    //   setState(() {});
    //   return;
    // }
    // if (!isEmailValid(email)) {
    //   _validationEmail = 'Enter a valid email address';
    //   setState(() {});
    //   return;
    // }
    if (widget.checkExisted && !email.isEmpty && isEmailValid(email)) {
      // do async validation
      _isCheckingEmail = true;
      setState(() {});
      //it's just faking delay, make your won async validation here
      try {
        var existed = await isExistEmail(email);
        if (existed) {
          _validationEmail = "Your email is taken";
        } else {
          _validationEmail = null;
        }
      } on FirebaseAuthException catch (e) {
        print(e.message);
      }
      _isCheckingEmail = false;
    }
    _validationEmail = null;
    setState(() {});
    return;
  }

  bool isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  Future<bool> isExistEmail(String email) async {
    var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (methods.contains('password')) {
      return true;
    }
    return false;
  }
}
