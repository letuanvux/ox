import 'package:flutter/material.dart';

import 'dial_user_pic.dart';


class UserCallingCard extends StatelessWidget {
  const UserCallingCard({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  final String name, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF091C40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DialUserPic(
            size: 112,
            image: image,
          ),
          SizedBox(height: 10,),
          Text(
            name,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 10,),
          Text(
            "Calling…",
            style: TextStyle(color: Colors.white60),
          )
        ],
      ),
    );
  }
}