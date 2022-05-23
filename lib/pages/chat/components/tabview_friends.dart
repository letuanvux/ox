import 'package:flutter/material.dart';
import 'package:ox/pages/chat/messager_detail_page.dart';

import '../models/chat_user.dart';
import 'friend_card.dart';

class TabViewFriends extends StatelessWidget {
  final List<ChatUser> chatUsers;

  const TabViewFriends({
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
              return FriendCard(
                user: chatUsers[index],
                isOnline : (index == 0 || index == 3) ? true : false,
              );
            },
          ),
        ],
      ),
    );
  }
}
