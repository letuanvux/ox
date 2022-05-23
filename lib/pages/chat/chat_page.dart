
import 'package:flutter/material.dart';

import '../../configs/routes.dart';
import 'components/chat_user_card.dart';
import 'models/chat_user.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({ Key? key }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _selectedIndex = 1;

  List<ChatUser> chatUsers = [
    ChatUser(text: "Jane Russel", secondaryText: "Awesome Setup", image: "assets/images/logo.png", time: "Now"),
    ChatUser(text: "Glady's Murphy", secondaryText: "That's Great", image: "assets/images/logo.png", time: "Yesterday"),
    ChatUser(text: "Jorge Henry", secondaryText: "Hey where are you?", image: "assets/images/logo.png", time: "31 Mar"),
    ChatUser(text: "Philip Fox", secondaryText: "Busy! Call me in 20 mins", image: "assets/images/logo.png", time: "28 Mar"),
    ChatUser(text: "Debra Hawkins", secondaryText: "Thankyou, It's awesome", image: "assets/images/logo.png", time: "23 Mar"),
    ChatUser(text: "Jacob Pena", secondaryText: "will update you in evening", image: "assets/images/logo.png", time: "17 Mar"),
    ChatUser(text: "Andrey Jones", secondaryText: "Can you please share the file?", image: "assets/images/logo.png", time: "24 Feb"),
    ChatUser(text: "John Wick", secondaryText: "How are you?", image: "assets/images/logo.png", time: "18 Feb"),
    ChatUser(text: "Jane Russel", secondaryText: "Awesome Setup", image: "assets/images/logo.png", time: "Now"),
    ChatUser(text: "Glady's Murphy", secondaryText: "That's Great", image: "assets/images/logo.png", time: "Yesterday"),
    ChatUser(text: "Jorge Henry", secondaryText: "Hey where are you?", image: "assets/images/logo.png", time: "31 Mar"),
    ChatUser(text: "Philip Fox", secondaryText: "Busy! Call me in 20 mins", image: "assets/images/logo.png", time: "28 Mar"),
    ChatUser(text: "Debra Hawkins", secondaryText: "Thankyou, It's awesome", image: "assets/images/logo.png", time: "23 Mar"),
    ChatUser(text: "Jacob Pena", secondaryText: "will update you in evening", image: "assets/images/logo.png", time: "17 Mar"),
    ChatUser(text: "Andrey Jones", secondaryText: "Can you please share the file?", image: "assets/images/logo.png", time: "24 Feb"),
    ChatUser(text: "John Wick", secondaryText: "How are you?", image: "assets/images/logo.png", time: "18 Feb"),
    ChatUser(text: "Jane Russel", secondaryText: "Awesome Setup", image: "assets/images/logo.png", time: "Now"),
    ChatUser(text: "Glady's Murphy", secondaryText: "That's Great", image: "assets/images/logo.png", time: "Yesterday"),
    ChatUser(text: "Jorge Henry", secondaryText: "Hey where are you?", image: "assets/images/logo.png", time: "31 Mar"),
    ChatUser(text: "Philip Fox", secondaryText: "Busy! Call me in 20 mins", image: "assets/images/logo.png", time: "28 Mar"),
    ChatUser(text: "Debra Hawkins", secondaryText: "Thankyou, It's awesome", image: "assets/images/logo.png", time: "23 Mar"),
    ChatUser(text: "Jacob Pena", secondaryText: "will update you in evening", image: "assets/images/logo.png", time: "17 Mar"),
    ChatUser(text: "Andrey Jones", secondaryText: "Can you please share the file?", image: "assets/images/logo.png", time: "24 Feb"),
    ChatUser(text: "John Wick", secondaryText: "How are you?", image: "assets/images/logo.png", time: "18 Feb"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: "Chat ",
                style: TextStyle(                  
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                children: [
              TextSpan(
                text: 'Messages',
                style: TextStyle(       
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                ),
              ),              
            ])),
        
        backgroundColor: Colors.white,
        toolbarHeight: 40,       
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, VLTxRoutes.home);
            }, 
            icon: Icon(Icons.add,
              color: Theme.of(context).colorScheme.primary
            )
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, VLTxRoutes.home);
            }, 
            icon: Icon(Icons.qr_code,
              color: Theme.of(context).colorScheme.primary
            )
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, VLTxRoutes.home);
            }, 
            icon: Icon(Icons.search,
              color: Theme.of(context).colorScheme.primary
            )
          ),
        ], 
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ChatUserCard(
                  user: chatUsers[index],                  
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          label: "Profile",
        ),
      ],
    );
  }
}