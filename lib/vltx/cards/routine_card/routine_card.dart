import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../card.dart';

class RoutineCard extends StatelessWidget {
  final String classTopic;
  final String? classType;
  final String subject;
  final String professor;
  final String time;

  const RoutineCard({
    Key? key,
    required this.classTopic,
    this.classType,
    required this.subject,
    required this.professor,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VLTxCard(
      active: true,
      height: ScreenUtil().setHeight(210),
      width: ScreenUtil().setWidth(374),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(64),
                height: ScreenUtil().setWidth(64),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(10),
                  ),
                ),
                child: Icon(
                  FontAwesomeIcons.book,
                  color: VLTxColors.blue,
                  size: FontSize.fontSize28,
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(15),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenUtil().setWidth(240),
                      child: Text(
                        '$classTopic',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.fontSize18,
                          fontWeight: FontSize.semiBold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(240),
                      child: Text(
                        '${classType ?? ''}',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: FontSize.fontSize14,
                          fontWeight: FontSize.regular,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Subject',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: FontSize.fontSize14,
                      fontWeight: FontSize.regular,
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(150),
                    height: ScreenUtil().setHeight(20),
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Text(
                        '$subject',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.fontSize14,
                          fontWeight: FontSize.semiBold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Professor/Teacher',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: FontSize.fontSize14,
                        fontWeight: FontSize.regular,
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$professor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.fontSize14,
                          fontWeight: FontSize.semiBold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            width: ScreenUtil().setWidth(132),
            height: ScreenUtil().setHeight(32),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(5),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '$time',
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.fontSize14,
                fontWeight: FontSize.semiBold,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
