
import 'package:flutter/material.dart';

import '../models/chat_message.dart';

class ChatMessageCard extends StatelessWidget {
  final ChatMessage item;
  const ChatMessageCard({ Key? key, required this.item }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Align(
        alignment: (item.type == MessageType.Receiver?Alignment.topLeft:Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (item.type  == MessageType.Receiver?Colors.white:Colors.grey.shade200),
          ),
          padding: EdgeInsets.all(16),
          child: Text(item.message),
        ),
      ),
    );
  }
}
