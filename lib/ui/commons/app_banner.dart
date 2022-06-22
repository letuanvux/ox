import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  final String imgUrl;
  const AppBanner({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          height: 400,
          width: double.infinity,
          child: Hero(
            tag: imgUrl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const Icon(
              Icons.favorite_outline_outlined,
              color: Colors.pink,
            ),
          ),
        ),
      ],
    );
  }
}
