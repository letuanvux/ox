import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/upload.dart';
import '../utils/utils.dart';

// ignore: must_be_immutable
class AppPhoto extends StatefulWidget {
  final TextEditingController controller;
  final String directory;
  final String defaultImage;
  late String? url;
  AppPhoto({
    Key? key,
    required this.controller,
    required this.directory,
    required this.defaultImage,
    this.url,
  }) : super(key: key);

  @override
  State<AppPhoto> createState() => _AppPhotoState();
}

class _AppPhotoState extends State<AppPhoto> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.07),
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(5.0))),
          ),
        ),
        Center(
          child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(5.0))),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: widget.url != null ? DecorationImage(
                      image:  Utils.getImageUrl(
                          widget.url ?? widget.defaultImage),
                      fit: BoxFit.cover) : null),
            ),
          ),
        ),
        Positioned(
          right: 5,
          bottom: 5,
          child: GestureDetector(
            child: Container(
              height: 25,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(ScreenUtil().setWidth(5.0)),
                    topLeft: Radius.circular(ScreenUtil().setWidth(5.0)),
                  )),
              alignment: Alignment.center,
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 25,
                color: Colors.black45,
              ),
            ),
            onTap: () {
              uploadImage();
            },
          ),
        ),
      ],
    );
  }

  uploadImage() async {
    var imgPath = await Upload.image(widget.directory);
    if (imgPath != null) {
      setState(() {
        widget.url = imgPath;
        widget.controller.text = imgPath;
      });
    }
  }
}
