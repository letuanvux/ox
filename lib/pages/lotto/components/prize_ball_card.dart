import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../configs/themes.dart';
import '../../../models/prize.dart';
import '../../../models/prize_number.dart';
import 'number_card.dart';

class PrizeBallCard extends StatelessWidget {
  const PrizeBallCard({
    Key? key,
    required this.prize,
    required this.items,
  }) : super(key: key);

  final Prize prize;
  final List<PrizeNumber> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [              
              RichText(
                text: TextSpan(
                    text: 'Date: ',
                    style: TextStyle(
                      fontSize: 16,                      
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                    children: [
                  TextSpan(
                    text: DateFormat('dd-MM-yyyy').format(prize.drawtime),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                    ),
                  )
                ])), 
              RichText(
                text: TextSpan(
                    text: 'No: ',
                    style: TextStyle(
                      fontSize: 16,                      
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                    children: [
                  TextSpan(
                    text: prize.code,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ])),             
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              height: 1,
            ),
          ),
          Center(
            child: Wrap(
              spacing: 3,
              runSpacing: 3,
              alignment: WrapAlignment.center,
              children: items.map((PrizeNumber item) {
                return NumberCard(
                  number: item.number,
                  color: item.isoption == true ? Colors.orange : Colors.red,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
