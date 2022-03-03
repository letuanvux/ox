import 'package:flutter/material.dart';

class NumberCard extends StatelessWidget {
  final String number;
  final Color color;
  const NumberCard({Key? key, required this.number, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color.withOpacity(0.7), width: 3),
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

