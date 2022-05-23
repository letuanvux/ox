import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'configs/routes.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OX - Thông tin xố số',
      theme: ThemeData(        
        primarySwatch: Colors.green,
        primaryColor: Colors.green, // outdated and has no effect to Tabbar
        fontFamily: GoogleFonts.openSans().fontFamily,     
        // add tabBarTheme 
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.blueGrey[300],
          labelColor: Colors.green,           
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.green, width: 2.0),
          ),
        ),           
      ),
      routes: VLTxRoutes.routes(),
      initialRoute: VLTxRoutes.splash,
    );
  }
}
