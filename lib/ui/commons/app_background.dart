import 'package:flutter/material.dart';
import 'package:ox/ui/themes.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    Key? key,
    this.image ='',
  }) : super(key: key);

  final String image;

  // @override
  // Widget build(BuildContext context) {
  //   String random = 'https://source.unsplash.com/featured/?wallpaper';
  //   return Container(
  //     height: MediaQuery.of(context).size.height,
  //     width: MediaQuery.of(context).size.width,
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //         image: image.isEmpty ? Image.network(random).image : AssetImage(image),
  //         fit: BoxFit.cover
  //       )
  //     ),              
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    String random = 'https://source.unsplash.com/featured/?wallpaper';
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: VLTxTheme.image(image.isEmpty ? random : image),
          fit: BoxFit.cover
        )
      ),              
    );
  }
}