import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../../utils/font_size.dart';


class OverlappingButtonCard extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final Widget? child;
  final EdgeInsets? padding;
  final double? height;
  final double? width;

  const OverlappingButtonCard({
    Key? key,
    this.onPressed,
    required this.label,
    this.padding,
    this.height,
    this.width,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(20),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: ScreenUtil().setWidth(34),
                  color: VLTxColors.blackShadow,
                  offset: Offset(
                    0,
                    ScreenUtil().setHeight(1),
                  ),
                ),
              ]),
          child: child,
        ),
        Positioned(
          bottom: ScreenUtil().setHeight(30),
          child: FlatButton(
            onPressed: onPressed,
            disabledColor: VLTxColors.lightBlack,
            disabledTextColor: Colors.white54,
            textColor: VLTxColors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(10),
              ),
            ),
            color: VLTxColors.yellow,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(18),
                horizontal: ScreenUtil().setWidth(20),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: FontSize.fontSize16,
                  fontWeight: FontSize.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
