// import 'package:flutter/material.dart';

// class AppBackground extends StatelessWidget {
//   const AppBackground({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("assets/images/bg_cloud.jpg"),
//           fit: BoxFit.cover
//         )
//       )
//     );
//   }
// }

import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    Key? key,
    this.image ='',
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    String random = 'https://source.unsplash.com/featured/?wallpaper';
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image.isEmpty ? Image.network(random).image : AssetImage(image),
          fit: BoxFit.cover
        )
      ),              
    );
  }
}