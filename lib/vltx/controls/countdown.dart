import 'dart:async';

import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  final Duration duration;
  final bool countDown;
  const CountDown({Key? key, required this.duration, this.countDown = true}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late Duration endTimer;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    endTimer = widget.duration;
    final int addSeconds = widget.countDown ? -1 : 1;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final seconds = endTimer.inSeconds + addSeconds;      
      setState(() {
        if (seconds < 0) {
        timer.cancel();
        } else {
          endTimer -= const Duration(seconds: 1);
        }        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(endTimer.inHours);
    final minutes = twoDigits(endTimer.inMinutes.remainder(60));
    final seconds = twoDigits(endTimer.inSeconds.remainder(60));
    return Row(
      children: [
        const Icon(Icons.av_timer_outlined),
        const SizedBox(width: 5,),
        Text('${hours} : ${minutes} : ${seconds}'),
      ],
    );
  }
}

