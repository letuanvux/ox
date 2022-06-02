import 'package:flutter/material.dart';
import 'dart:async';

import '../app.dart';
import 'themes.dart';
import 'commons/app_background.dart';
import 'commons/app_logo.dart';

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
            MaterialPageRoute(builder: (context) => const App()),
          )
    );
  }

  @override
  Widget build(BuildContext context) {    
    final size = MediaQuery.of(context).size; 
    
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
                text: "Nếu bạn mất ",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                children: [
                TextSpan(
                  text: 'tự tin',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),  
                TextSpan(
                  text: ". Hãy để chúng tôi ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ), 
                TextSpan(
                  text: 'dẫn lối',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),              
              ]
            )
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Theme.of(context).colorScheme.primary.withOpacity(.24),          
        ),
      body : Stack(
        children: [
          AppBackground(image: VLTxTheme.bgImage),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [                          
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 250, child: AppLogo()),                      
                      SizedBox(
                        width: size.width / 3,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            children: [
                              Text("Lotte",
                                  style: TextStyle(
                                      color: Color.fromARGB(221, 19, 19, 19),
                                      fontWeight: FontWeight.w600)),
                              Text("rix",
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        )),
                                                                 
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
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
                ), 
              ],
            ),
          ), 
        ],
      )             
    );
  }
}