import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [                  
            CircleAvatar(
              radius: 115.0,
              backgroundColor: Colors.white.withOpacity(0.05),
              child: CircleAvatar(
                radius: 96.0,
                backgroundColor: Colors.white.withOpacity(0.1),
                child: CircleAvatar(
                  radius: 79.0,
                  backgroundColor: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            Container(
              width: 200.0,
              height: 200.0,
              child: Image.asset("assets/images/logo_red.png"),
            ),                  
          ],
        ),
      ),
    );
  }
}