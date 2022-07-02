import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../card.dart';
import '../label_card/label_card.dart';

class NoticeCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function()? onTap;
  final String date;

  const NoticeCard({
    Key? key,
    required this.title,
    required this.subTitle,
    this.onTap,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VLTxCard(
      active: true,
      height: ScreenUtil().setHeight(250),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: ScreenUtil().setWidth(48),
            width: ScreenUtil().setWidth(48),
            decoration: BoxDecoration(
              color: VLTxColors.darkYellow,
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(10),
              ),
            ),
            child: Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: Colors.white,
              size: FontSize.fontSize20,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontSize.semiBold,
              letterSpacing: 1.0,
              fontSize: FontSize.fontSize16,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontSize.regular,
              fontSize: FontSize.fontSize16,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              LabelCard(
                label: date,
              ),
              Expanded(
                child: Container(),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  'READ MORE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontSize.bold,
                    fontSize: FontSize.fontSize16,
                  ),
                ),
              ),
              IconButton(
                onPressed: onTap,
                icon: Icon(
                  FontAwesomeIcons.arrowRight,
                  color: Colors.white,
                  size: FontSize.fontSize20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
