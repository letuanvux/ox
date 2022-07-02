import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import '../utils/font_size.dart';


class OutlinedButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final bool busy;
  final EdgeInsets? padding;

  const OutlinedButton({
    Key? key,
    this.onPressed,
    required this.label,
    this.busy = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: onPressed != null
              ? VLTxColors.blue
              : VLTxColors.lightGrey,
          width: ScreenUtil().setWidth(1.5),
        ),
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(5.0),
        ),
      ),
      disabledColor: Colors.white,
      color: Colors.white,
      textColor: VLTxColors.blue,
      disabledTextColor: VLTxColors.grey,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(16),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '$label',
              style: TextStyle(
                fontSize: FontSize.fontSize16,
                fontWeight: FontSize.semiBold,
              ),
            ),
            if (busy) ...[
              SizedBox(
                width: ScreenUtil().setWidth(10),
              ),
              Theme(
                data: ThemeData(
                  accentColor: VLTxColors.blue,
                ),
                child: Container(
                  height: ScreenUtil().setWidth(15),
                  width: ScreenUtil().setWidth(15),
                  child: const CircularProgressIndicator(),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
