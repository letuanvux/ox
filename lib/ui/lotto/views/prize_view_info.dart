import 'package:flutter/material.dart';

import '../components/prize_ball_card.dart';
import '../components/prize_card.dart';
import '../models/bridge.dart';
import '../models/lotto.dart';
import '../models/prize.dart';
import '../models/prize_number.dart';

class PrizeViewInfo extends StatelessWidget {  
  final Lotto lotto;
  final Prize prize;
  final List<PrizeNumber> items;
  final LottoBridge? bridge;
  const PrizeViewInfo({
    Key? key,
    required this.lotto,
    required this.prize,
    required this.items,
    this.bridge
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lotto.isball ? PrizeBallCard(prize: prize, items: items)
                      : PrizeCard(item: prize, bridge: bridge),
          // Prize
        ],
      ),
    );
  }
}