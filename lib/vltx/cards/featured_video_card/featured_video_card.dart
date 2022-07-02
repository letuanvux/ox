import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../../utils/font_size.dart';

class FeaturedVideoCard extends StatelessWidget {
  final String thumbnailURL;
  final Function()? onTap;
  final String? title;

  const FeaturedVideoCard({
    Key? key,
    required this.thumbnailURL,
    this.onTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(10),
        ),
        child: SizedBox(
          height: ScreenUtil().setHeight(220),
          child: CachedNetworkImage(
            imageUrl: 'https://loremflickr.com/100/100/mu4sic?lock=9',
            imageBuilder: (context, imageProvider) => Container(              
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.35,
                    child: Container(
                      //width: ScreenUtil().setWidth(374),
                      height: ScreenUtil().setHeight(220),
                      color: VLTxColors.black,
                    ),
                  ),
                  Center(
                    child: Icon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: FontSize.fontSize36,
                    ),
                  ),
                  Positioned(
                    bottom: ScreenUtil().setHeight(10),
                    left: ScreenUtil().setWidth(20),
                    child: SizedBox(
                      width: 315,
                      child: Text(
                        title ?? 'Untitled',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.fontSize16,
                          fontWeight: FontSize.bold,
                        ),
                      ),
                    ),
                  ), 
                ],
              ),
            ),
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Center(child:Icon(Icons.error)),
          ),
        ),
      ),
    );    


    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(10),
        ),
        child: Container(
          width: ScreenUtil().setWidth(374),
          height: ScreenUtil().setHeight(222),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(thumbnailURL),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.35,
                child: Container(
                  width: ScreenUtil().setWidth(374),
                  height: ScreenUtil().setHeight(222),
                  color: VLTxColors.black,
                ),
              ),
              Center(
                child: Icon(
                  FontAwesomeIcons.play,
                  color: Colors.white,
                  size: FontSize.fontSize36,
                ),
              ),
              Positioned(
                bottom: ScreenUtil().setHeight(10),
                left: ScreenUtil().setWidth(20),
                child: SizedBox(
                  width: 315,
                  child: Text(
                    title ?? 'Untitled',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.fontSize16,
                      fontWeight: FontSize.bold,
                    ),
                  ),
                ),
              ),   
            ],
          ),
        ),
      ),
    ); 
  }
}
