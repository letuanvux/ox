import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AppBackground extends StatelessWidget {
  final String image;

  const AppBackground({
    Key? key,
    this.image ='',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String random = 'https://source.unsplash.com/featured/?wallpaper';
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Utils.getImageUrl(image.isEmpty ? random : image),
          fit: BoxFit.cover
        )
      ),              
    );
  }
}