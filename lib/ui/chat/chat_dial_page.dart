import 'package:flutter/material.dart';

import 'components/dial_button.dart';
import 'components/dial_user_pic.dart';
import 'components/rounded_button.dart';

class ChatDialPage extends StatefulWidget {
  const ChatDialPage({ Key? key }) : super(key: key);

  @override
  State<ChatDialPage> createState() => _ChatDialPageState();
}

class _ChatDialPageState extends State<ChatDialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF091C40),
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Anna williams",
              style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white),
            ),
            Text(
              "Calling…",
              style: TextStyle(color: Colors.white60),
            ),
            Spacer(),
            DialUserPic(image: "assets/images/logo_red.png"),
            Spacer(),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                DialButton(
                  iconSrc: "assets/icons/Icon Mic.svg",
                  text: "Audio",
                  press: () {},
                ),
                DialButton(
                  iconSrc: "assets/icons/Icon Volume.svg",
                  text: "Microphone",
                  press: () {},
                ),
                DialButton(
                  iconSrc: "assets/icons/Icon Video.svg",
                  text: "Video",
                  press: () {},
                ),
                DialButton(
                  iconSrc: "assets/icons/Icon Message.svg",
                  text: "Message",
                  press: () {},
                ),
                DialButton(
                  iconSrc: "assets/icons/Icon User.svg",
                  text: "Add contact",
                  press: () {},
                ),
                DialButton(
                  iconSrc: "assets/icons/Icon Voicemail.svg",
                  text: "Voice mail",
                  press: () {},
                ),
              ],
            ),
            Spacer(),
            RoundedButton(
              iconSrc: "assets/icons/call_end.svg",
              press: () {},
              color: Color(0xFFFF1E46),
              iconColor: Colors.white,
            )
          ],
        ),
      ),
      ),
    );
  }
}