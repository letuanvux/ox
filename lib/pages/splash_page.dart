import 'package:flutter/material.dart';
import 'dart:async';

import 'home_page.dart';

//import 'app.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {     

  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          )
    );
  }

  @override
  Widget build(BuildContext context) {    
    final size = MediaQuery.of(context).size; 
    
    return Scaffold(
      body : Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_cloud.jpg"),
                fit: BoxFit.cover)
              )
            ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ 
                  Center(
                    child: SizedBox(
                      width: size.width / 5,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          children: const [
                            Text("Lotte",
                                style: TextStyle(
                                    color: Color(0xff010036),
                                    fontWeight: FontWeight.w600)),
                            Text("rix",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )),
                  ),                                                  
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/logo_red.png", scale: 1),
                        const SizedBox(height: 10),                                               
                      ],
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                      children: [
                        TextSpan(
                          text: "© 2022 ",
                          style: TextStyle(color: Colors.black),
                        ),  
                        TextSpan(
                          text: "VLTx, Inc.",
                          style: TextStyle(color: Colors.green),
                        ),                  
                      ],
                    ),
                  ), 
                ],
              ),
            ),
          ), 
        ],
      )             
    );
  }
}