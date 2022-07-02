import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import '../utils/font_size.dart';

class VLTxPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final String? errorText;
  final String? label;
  final String? hint;

  const VLTxPasswordField({
    Key? key,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onTap,
    this.errorText,
    this.label,
    this.hint,
  }) : super(key: key);

  @override
  State<VLTxPasswordField> createState() => _VLTxPasswordFieldState();
}

class _VLTxPasswordFieldState extends State<VLTxPasswordField> {
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,      
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTap: widget.onTap,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isObscureText,
      textInputAction: TextInputAction.next,
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
      decoration: InputDecoration(
        fillColor: VLTxColors.blueGrey,
        filled: true,
        hintStyle: TextStyle(
          fontSize: FontSize.fontSize18,
          color: VLTxColors.mediumGrey,
        ),
        hintText: widget.hint,
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(5.0),
          ),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(5.0),
          ),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(5.0),
          ),
          borderSide: const BorderSide(
            color: VLTxColors.lightBlue,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
        ),
        errorText: widget.errorText,
        labelText: widget.label,
      ),
      
      
    );
  }
}
