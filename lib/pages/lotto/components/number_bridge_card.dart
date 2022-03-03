import 'package:flutter/material.dart';
import 'package:ox/helpers/lotto_helper.dart';
import 'package:ox/models/bridge.dart';

import '../../../models/prize_number.dart';

class NumberBridgeCard extends StatelessWidget {
  final PrizeNumber prize;
  final LottoBridge? bridge;
  const NumberBridgeCard({Key? key, required this.prize, this.bridge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (prize.group == 0 && prize.position == 0) {
      return SizedBox(
        height: 30,
        child: Center(
          child: Text(
            LottoHelper.markBridge(prize, bridge),
            style: const TextStyle(
                color: Color(0xffcf475f),
                fontWeight: FontWeight.w800,
                fontSize: 18),
          ),
        ),
      );
    } else {
      return Text(
        LottoHelper.markBridge(prize, bridge),
        style: const TextStyle(fontSize: 16),
      );
    }    
  }
}
