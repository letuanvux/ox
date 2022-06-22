import 'package:flutter/material.dart';

class ProfileBanner extends StatelessWidget {
  const ProfileBanner({ Key? key }) : super(key: key);

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
            tag: 'assets/images/events/event12.jpg',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/events/event12.jpg',
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
              color: Colors.white,
              shape: BoxShape.circle
            ),
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