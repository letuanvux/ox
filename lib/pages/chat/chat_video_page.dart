import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/rounded_button.dart';
import 'components/user_calling_card.dart';

class ChatVideoPage extends StatefulWidget {
  const ChatVideoPage({ Key? key }) : super(key: key);

  @override
  State<ChatVideoPage> createState() => _ChatVideoPageState();
}

class _ChatVideoPageState extends State<ChatVideoPage> {
  List<Map<String, dynamic>> demoData = [
  {
    "isCalling": false,
    "name": "User 1",
    "image": "assets/images/logo.png",
  },
  {
    "isCalling": true,
    "name": "Steve jon",
    "image": "assets/images/logo.png",
  },
  {
    "isCalling": false,
    "name": "User 1",
    "image": "assets/images/logo.png",
  },
  {
    "isCalling": false,
    "name": "User 1",
    "image": "assets/images/logo.png",
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: demoData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => demoData[index]["isCalling"]
          ? UserCallingCard(
              name: "Steve jon",
              image: "assets/images/logo.png",
            )
          : Image.asset(
              demoData[index]['image'],
              fit: BoxFit.cover,
            ),
    ),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  Container buildBottomNavBar() {
    return Container(
      color: Color(0xFF091C40),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RoundedButton(
                color: Color(0xFFFF1E46),
                iconColor: Colors.white,
                size: 48,
                iconSrc: "assets/icons/Icon Close.svg",
                press: () {},
              ),              
              RoundedButton(
                color: Color(0xFF2C384D),
                iconColor: Colors.white,
                size: 48,
                iconSrc: "assets/icons/Icon Volume.svg",
                press: () {},
              ),
              RoundedButton(
                color: Color(0xFF2C384D),
                iconColor: Colors.white,
                size: 48,
                iconSrc: "assets/icons/Icon Mic.svg",
                press: () {},
              ),
              RoundedButton(
                color: Color(0xFF2C384D),
                iconColor: Colors.white,
                size: 48,
                iconSrc: "assets/icons/Icon Video.svg",
                press: () {},
              ),
              RoundedButton(
                color: Color(0xFF2C384D),
                iconColor: Colors.white,
                size: 48,
                iconSrc: "assets/icons/Icon Repeat.svg",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/Icon Back.svg"),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/Icon User.svg",
            height: 24,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
