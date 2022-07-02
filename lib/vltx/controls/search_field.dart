import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import '../utils/font_size.dart';

class SearchField extends StatefulWidget {
  final String text;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final String? errorText;
  final String? label;
  final String? hint;

  const SearchField({
    Key? key,
    required this.text,
    this.obscureText = false,
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
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          fontSize: FontSize.fontSize18,
          color: VLTxColors.mediumGrey,
        ),
        hintText: widget.hint,
        prefixIcon: Icon(Icons.search,
          color: Colors.grey.shade500,
          size: 20,
        ),
        suffixIcon: widget.text.isNotEmpty
          ? GestureDetector(
              child: const Icon(Icons.close),
              onTap: () {
                widget.controller!.clear();
                widget.onChanged!('');
                FocusScope.of(context).requestFocus(FocusNode());
              },
            )
          : null, 
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
