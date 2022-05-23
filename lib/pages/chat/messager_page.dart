import 'package:flutter/material.dart';
import 'package:ox/pages/chat/components/tabview_friends.dart';
import 'package:ox/pages/map_page.dart';
import 'package:ox/pages/scan_page.dart';

import '../../constants.dart';
import '../widgets/app_background.dart';
import 'components/tabview_messages.dart';
import 'models/chat_user.dart';

class MessagerPage extends StatefulWidget {
  const MessagerPage({ Key? key }) : super(key: key);

  @override
  State<MessagerPage> createState() => _MessagerPageState();
}

class _MessagerPageState extends State<MessagerPage> with TickerProviderStateMixin{
  late TabController tabController;
  int currentTabIndex = 0;

  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      onTabChange();
    });
    super.initState();    
  }

  @override
  void dispose() {
    tabController.addListener(() {
      onTabChange();
    });

    tabController.dispose();

    super.dispose();
  }

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
        toolbarHeight: 40,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade100,
        // elevation: 0,
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(.8),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MapPage();
              }));
          },
          icon: Icon(Icons.map_outlined),
          color: Theme.of(context).colorScheme.primary,
        ),
        leadingWidth: 50,
        title: RichText(
          text: TextSpan(
              text: "Connect ",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
              children: [
            TextSpan(
              text: 'friends',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.normal,
              ),
            ),
          ])),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_2_outlined),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ScanPage();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {},
          )
        ],        
      ),  
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          currentTabIndex == 0
              ? Icons.message
              : currentTabIndex == 1
                  ? Icons.qr_code_scanner
                  : Icons.call,
          color: Colors.white,
          size: 16,
        ),
      ),      
      body: Stack(children: [
        AppBackground(image: bgImage),
        Column(
          children: [
            Container(
              color: Colors.grey[100],
              child: TabBar(
                padding: EdgeInsets.only(top: 5),
                controller: tabController, 
                tabs: [
                  Tab(icon: Text('Tin nhắn'), height: 30,),
                  Tab(icon: Text('Bạn bè'), height: 30,),
                  Tab(icon: Text('Danh bạ'), height: 30,),          
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  TabViewMessages(chatUsers: chatUsers),
                  TabViewFriends(chatUsers: chatUsers),
                  Center(child: Text('Call')),
                ],
              ),
            ),
          ],
        ),        
      ]),
    );
  }
}

