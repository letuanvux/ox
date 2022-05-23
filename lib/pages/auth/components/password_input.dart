import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const PasswordInput({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isObscureText = !_isObscureText;
            });
          },
          child: Icon(
            _isObscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isObscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required";
        }
        if (value.length < 6) {
          return "Password must be atleast 6 characters long";
        }
        if (value.length > 20) {
          return "Password must be less than 20 characters";
        }
        if (!value.contains(RegExp(r'[0-9]'))) {
          return "Password must contain a number";
        }
        return null;
      },
    );
  }
}
