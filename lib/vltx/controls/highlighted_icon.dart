import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import '../utils/font_size.dart';

class HighlightedIcon extends StatelessWidget {
  final IconData icon;
  final bool busy;

  const HighlightedIcon({
    Key? key,
    required this.icon,
    this.busy = false,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(124),
          height: ScreenUtil().setWidth(124),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: VLTxColors.blueGrey,
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(94),
          height: ScreenUtil().setHeight(94),
          constraints: BoxConstraints(
            maxHeight: ScreenUtil().setHeight(94),
            maxWidth: ScreenUtil().setHeight(94),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: ScreenUtil().setWidth(21),
                color: VLTxColors.greyShadow,
                offset: Offset(
                  0,
                  ScreenUtil().setHeight(3),
                ),
              ),
            ],
          ),
          child: busy
              ? Center(
                  child: Theme(
                    data: ThemeData(
                      primaryColor: VLTxColors.blue,
                      accentColor: VLTxColors.blue,
                    ),
                    child: SizedBox(
                      height: ScreenUtil().setWidth(32),
                      width: ScreenUtil().setWidth(32),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                )
              : Icon(
                  icon,
                  color: VLTxColors.blue,
                  size: FontSize.fontSize30,
                ),
        ),
      ],
    );
  }
}
