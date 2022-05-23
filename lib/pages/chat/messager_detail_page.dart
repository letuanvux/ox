import 'package:flutter/material.dart';

import 'components/chat_composer.dart';
import 'components/conversation.dart';
import 'models/chat_user.dart';

class MessagerDetailPage extends StatefulWidget {
  final ChatUser user;
  const MessagerDetailPage({ Key? key, required this.user }) : super(key: key);

  @override
  State<MessagerDetailPage> createState() => _MessagerDetailPageState();
}

class _MessagerDetailPageState extends State<MessagerDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(   
        backgroundColor: Theme.of(context).primaryColor, 
        leadingWidth: 30,    
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'assets/images/logo.png',
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.text,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'online',    
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: Colors.grey[200]
                  ),              
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.videocam_outlined,
                size: 28,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.call,
                size: 28,
              ),
              onPressed: () {})
        ],
        elevation: 0,
      ),      
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: Container(  
                width: double.infinity,              
                padding: EdgeInsets.symmetric(horizontal: 10),                
                child: Conversation(user: widget.user),
              ),
            ),
            ChatComposer(),
          ],
        ),
      )
    );
  }
}