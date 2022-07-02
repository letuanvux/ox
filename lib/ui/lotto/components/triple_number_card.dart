import 'package:flutter/material.dart';

import '../helpers/lotto_helper.dart';
import '../models/long_number.dart';
import '../models/lotto.dart';
import '../models/prize.dart';
import '../services/max_miss_day_service.dart';
import '../services/prize_service.dart';
import 'triple_number_tile.dart';

class TripleNumberCard extends StatefulWidget {
  final Lotto lotto;
  final List<Prize> prizes;
  const TripleNumberCard(
      {Key? key, required this.lotto, required this.prizes})
      : super(key: key);

  @override
  State<TripleNumberCard> createState() => _TripleNumberCardState();
}

class _TripleNumberCardState extends State<TripleNumberCard> {
  final itemService = PrizeService();
  final maxMissDayService = MaxMissDayService();

  late List<TripleNumber> items = [];
  late Future<List<TripleNumber>> lstTripleNumbers;

  @override
  initState() {
    super.initState();
    loadData();
    lstTripleNumbers = getItems();
  }

  Future<void> loadData() async {
    
  }

  Future<List<TripleNumber>> getItems() async {
    await Future.delayed(Duration(seconds: 3));
    return LottoHelper.getTripleNumbers(
        widget.prizes, widget.lotto.min, widget.lotto.max);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TripleNumber>>(
      future: lstTripleNumbers,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<TripleNumber>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            items = snapshot.data!;

            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text("Thống kê bộ 3 số"),
                SizedBox(
                  height: 360,
                  child: ListView.separated(
                    itemCount: (items.length / 10).round(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            const EdgeInsets.only(left: 0, right: 0, top: 10),
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index < (items.length / 10).round() - 1)
                              for (var i = 0; i < 10; i++)
                                TripleNumberTile(item: items[i + index * 10]),
                            if (index == (items.length / 10).round() - 1)
                              for (var i = index * 10; i < items.length; i++)
                                TripleNumberTile(item: items[i]),
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
          } else {
            return const SizedBox();
          }
        } else {
          return Text('Thống kê bộ 3 số');
        }
      },
    );
  }
}
