import 'package:flutter/material.dart';

import '../models/chat_user.dart';
import 'message_card.dart';

class TabViewMessages extends StatelessWidget {
  final List<ChatUser> chatUsers;

  const TabViewMessages({
    Key? key,
    required this.chatUsers,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: chatUsers.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return MessageCard(
                user: chatUsers[index],
                isMessageRead: (index == 0 || index == 3) ? true : false,
              );
            },
          ),
        ],
      ),
    );
  }
}
