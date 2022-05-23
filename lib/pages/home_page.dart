import 'package:flutter/material.dart';

import 'dashboard_page.dart';
import 'lotto/calendar_page.dart';
import 'lotto/lotto_page.dart';
import 'settings_page.dart';
import 'chat/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  final _pages = const [
    DashBoardPage(),
    CalendarPage(),
    LottoPage(),
    ChatPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      //extendBody: true,
      backgroundColor: const Color(0xFFEFF5F4).withOpacity(.98),
      bottomNavigationBar: BottomNavigationBar(
        elevation: .0,
        backgroundColor: const Color(0xFFEFF5F4).withOpacity(.98),
        currentIndex: currentPage,
        onTap: (i) {
          setState(() {
            currentPage = i;
          });
        },
        type: BottomNavigationBarType.fixed,
        iconSize: _size.width / 18.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.blueGrey[300],          
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),  
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar"), 
          BottomNavigationBarItem(
              icon: Icon(Icons.catching_pokemon_outlined), label: "Lottos"),           
          BottomNavigationBarItem(
              icon: Icon(Icons.message), label: "Messages"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
      body: _pages[currentPage],      
    );
  }
}