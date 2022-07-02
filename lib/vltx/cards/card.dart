import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class VLTxCard extends StatelessWidget {
  final Widget? child;
  final Color backgroundColor;
  final Color activeColor;
  final bool active;
  final Duration animationDuration;
  final Alignment alignment;
  final double? width;
  final double? height;
  final bool showShadow;
  final EdgeInsets? margin;

  const VLTxCard({
    Key? key,
    this.child,
    this.backgroundColor = VLTxColors.blueGrey,
    this.activeColor = VLTxColors.blue,
    this.active = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.showShadow = false,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return AnimatedContainer(
      duration: animationDuration,
      padding: EdgeInsets.all(
        ScreenUtil().setWidth(15),
      ),
      margin: margin,
      curve: Curves.ease,
      width: width,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        color: active ? activeColor : backgroundColor,
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(10),
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  blurRadius: ScreenUtil().setHeight(15),
                  color: VLTxColors.blackShadow,
                  offset: Offset(
                    0,
                    ScreenUtil().setHeight(15),
                  ),
                  spreadRadius: ScreenUtil().setHeight(13),
                ),
              ]
            : [],
      ),
      child: child,
    );
  }
}
