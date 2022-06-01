import 'package:flutter/material.dart';

import '../models/long_number.dart';
import '../models/max_miss_day.dart';
import 'longnumber_tile.dart';

class LottoLongNumberCard extends StatelessWidget {
  final List<LongNumber> items;
  final List<MaxMissDay> maxDays;

  const LottoLongNumberCard({
    Key? key,
    required this.items,
    required this.maxDays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cap nhat Max Days
    if (maxDays.isNotEmpty) {
      items.forEach(
        (element) => element.maxdays =
            maxDays.where((o) => o.number == element.number).first.maxdays,
      );
    }

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text("Thống kê theo ngày không ra"),
        SizedBox(
          height: 360,
          child: ListView.separated(
            itemCount: (items.length / 10).round(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index < (items.length / 10).round() - 1)
                      for (var i = 0; i < 10; i++)
                        LongNumberTile(item: items[i + index * 10]),
                    if (index == (items.length / 10).round() - 1)
                      for (var i = index * 10; i < items.length; i++)
                        LongNumberTile(item: items[i]),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
          ),
        ),
      ],
    );
  }
}
