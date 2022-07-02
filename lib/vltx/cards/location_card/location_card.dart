import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../card.dart';

class LocationCard extends StatelessWidget {
  final String imageURL;
  final String address;
  final String name;

  const LocationCard({
    Key? key,
    required this.imageURL,
    required this.address,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VLTxCard(      
      height: ScreenUtil().setHeight(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setHeight(67),
            width: ScreenUtil().setWidth(67),
            child: CachedNetworkImage(
              imageUrl: imageURL,
              width: ScreenUtil().setHeight(67),
              height: ScreenUtil().setWidth(67),
              placeholder: (context, string) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(                  
                  height: ScreenUtil().setHeight(25),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: FontSize.fontSize16,
                        fontWeight: FontSize.bold,
                        color: VLTxColors.darkBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: VLTxColors.blue,
                      size: FontSize.fontSize18,
                    ),
                    Expanded(
                      child: SizedBox(                      
                        height: ScreenUtil().setHeight(25),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            address,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: FontSize.fontSize14,
                              color: VLTxColors.lightBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
