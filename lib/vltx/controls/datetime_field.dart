import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';
import '../utils/font_size.dart';

class VLTxDateTimeField extends StatefulWidget {
  final bool obscureText;
  final TextEditingController? controller;
  final DateTime? selectedDateTime;
  final String formatDate;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final String? errorText;
  final String? label;
  final String? hint;
  final String? helpText;

  const VLTxDateTimeField({
    Key? key,
    this.obscureText = false,
    this.controller,
    required this.selectedDateTime,
    this.formatDate = 'dd/MM/yyyy HH:mm',
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onTap,
    this.errorText,
    this.label,
    this.hint,
    this.helpText,
    required String? Function(dynamic value) validator,
  }) : super(key: key);

  @override
  _VLTxDateTimeFieldState createState() => _VLTxDateTimeFieldState();
}

class _VLTxDateTimeFieldState extends State<VLTxDateTimeField> {
  Future<void> pickDateTime(BuildContext context) async {
    print(widget.selectedDateTime);
    var initialDateTime = widget.selectedDateTime ?? DateTime.now();
    final DateTime? date = await showDatePicker(
        context: context,
        helpText: widget.helpText,
        initialDate: initialDateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: initialDateTime.hour, minute: initialDateTime.minute));

    if (time == null) return;

    var pickedDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    setState(() {
      widget.controller!.text =
          DateFormat(widget.formatDate).format(pickedDate);
    });
  }

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
            fontSize: FontSize.fontSize18,
            color: VLTxColors.mediumGrey,
          ),
          hintText: widget.hint,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.calendar_month,
              color: VLTxColors.mediumGrey,
              size: 25,
            ),
            onPressed: () {
              pickDateTime(context);
            },
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
              color: Colors.green,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
          ),
          errorText: widget.errorText,
          labelText: widget.label,
        ),
      ),
    );
  }
}
