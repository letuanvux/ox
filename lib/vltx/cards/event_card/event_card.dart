import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../card.dart';

class EventCard extends StatelessWidget {  
  final String time;
  final String event;
  final double? width;
  final double? height;
  final Color primaryColor;
  final Color secondaryColor;

  const EventCard({
    Key? key,
    required this.time,
    required this.event,
    this.width,
    this.height,    
    this.primaryColor = VLTxColors.brown,
    this.secondaryColor = VLTxColors.lightBrown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VLTxCard(
      width: width ?? ScreenUtil().setWidth(374),
      height: height ?? ScreenUtil().setHeight(80),
      backgroundColor: secondaryColor,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$time',
            style: TextStyle(
              color: VLTxColors.darkBlack,
              fontWeight: FontSize.semiBold,
              fontSize: FontSize.fontSize14,
            ),
          ),
          Text(
            '$event',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontSize.semiBold,
              fontSize: FontSize.fontSize16,
            ),
          ),
        ],
      ),
    );
  }
}
