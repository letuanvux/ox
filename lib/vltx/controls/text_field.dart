import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import '../utils/font_size.dart';

class VLTxTextField extends StatefulWidget {
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final String? errorText;
  final String? label;
  final String? hint;
  final TextInputType? keyboardType;
  final Function(String?)? validator;

  const VLTxTextField({
    Key? key,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onTap,
    this.errorText,
    this.label,
    this.hint,
    this.validator, 
    this.keyboardType,
  }) : super(key: key);

  @override
  _VLTxTextFieldState createState() => _VLTxTextFieldState();
}

class _VLTxTextFieldState extends State<VLTxTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
        onTap: widget.onTap,
        decoration: InputDecoration(
          fillColor: VLTxColors.blueGrey,
          filled: true,
          hintStyle: TextStyle(
            fontSize: FontSize.fontSize14,
            color: VLTxColors.mediumGrey,
          ),
          hintText: widget.hint,
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
              color: Colors.green,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
            vertical: ScreenUtil().setHeight(0),
          ),
          errorText: widget.errorText,
          labelText: widget.label,
        ),
      ),
    );
  }
}
