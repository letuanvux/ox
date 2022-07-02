import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'map_page.dart';
import 'scan_page.dart';
import 'video/video_page.dart';
import 'lotto/lotto_page.dart';

class App extends StatefulWidget {
  const App({ Key? key }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentPage = 0;
  final _pages = const [
    HomePage(),
    VideoPage(),
    MapPage(),
    LottoPage(),
    ScanPage(),
  ];

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
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
        iconSize: MediaQuery.of(context).size.width / 18.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.blueGrey[300],          
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),  
          BottomNavigationBarItem(
              icon: Icon(Icons.live_tv_sharp), label: "Live"), 
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