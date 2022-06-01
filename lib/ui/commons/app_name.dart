import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  final fontSize;
  const AppName({Key? key, this.fontSize = 14}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return RichText(
        text: TextSpan(
            text: "Lotte",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w600
            ),
        children: [
          TextSpan(
            text: 'rix',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ]));    
  }
}
