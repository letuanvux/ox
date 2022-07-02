import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';


class CustomCircularProgress extends StatelessWidget {
  final Color color;

  const CustomCircularProgress({
    Key? key,
    this.color = VLTxColors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return Theme(
      data: ThemeData(
        accentColor: color,
      ),
      child: SizedBox(
        height: ScreenUtil().setHeight(15),
        width: ScreenUtil().setWidth(15),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
