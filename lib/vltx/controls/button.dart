import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import '../utils/font_size.dart';


class VLTxButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final bool busy;

  const VLTxButton({
    Key? key,
    this.onPressed,
    required this.label,
    this.busy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(5.0),
        ),
      ),
      disabledColor: VLTxColors.lightBlack,
      color: VLTxColors.blue,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setWidth(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '$label',
              style: TextStyle(
                color: Colors.white,
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
                  primaryColor: VLTxColors.blue,
                  accentColor: Colors.white,
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
