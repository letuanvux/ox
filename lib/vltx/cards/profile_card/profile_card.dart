import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/colors.dart';
import '../card.dart';
import '../information_card/information_card.dart';
import '../video_list_tile_card/video_list_tile_card.dart';

class ProfileCard extends StatelessWidget {
  final String imageURL;
  final String name;
  final String? post;
  final String email;
  final String phoneNumber;
  final EdgeInsets? margin;
  final Function()? onPhoneNumberTap;
  final String? infoTitle;
  final String? info;

  const ProfileCard({
    Key? key,
    required this.imageURL,
    required this.name,
    this.post,
    required this.email,
    required this.phoneNumber,
    this.margin,
    this.onPhoneNumberTap,
    this.infoTitle,
    this.info,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VLTxCard(
      margin: margin,
      backgroundColor: Colors.white,
      showShadow: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          VideoListTileCard(
            title: name,
            author: post,
            thumbnailURL: imageURL,
            showIcon: false,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
          VLTxCard(
            backgroundColor: VLTxColors.blueGrey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InformationCard(
                  icon: FontAwesomeIcons.envelope,
                  title: 'Email',
                  subTitle: email,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                InformationCard(
                  icon: FontAwesomeIcons.phoneAlt,
                  title: 'Phone Number',
                  subTitle: phoneNumber,
                  onTap: onPhoneNumberTap,
                ),
                if (infoTitle != null) ...[
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  InformationCard(
                    icon: FontAwesomeIcons.info,
                    title: '$infoTitle',
                    subTitle: '$info',
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
