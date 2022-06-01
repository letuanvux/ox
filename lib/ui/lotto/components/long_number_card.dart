import 'package:flutter/material.dart';

import '../helpers/lotto_helper.dart';
import '../models/long_number.dart';
import '../models/lotto.dart';
import '../models/max_miss_day.dart';
import '../models/prize.dart';
import '../services/max_miss_day_service.dart';
import '../services/prize_service.dart';
import 'longnumber_tile.dart';

class LongNumberCard extends StatefulWidget {
  final Lotto lotto;
  final List<Prize> prizes;
  const LongNumberCard(
      {Key? key, required this.lotto, required this.prizes})
      : super(key: key);

  @override
  State<LongNumberCard> createState() => _LongNumberCardState();
}

class _LongNumberCardState extends State<LongNumberCard> {
  final itemService = PrizeService();
  final maxMissDayService = MaxMissDayService();

  late List<LongNumber> items = [];
  late List<MaxMissDay> lstMaxMissDays = [];

  late Future<List<LongNumber>> lstLongNumbers;

  @override
  initState() {
    super.initState();
    loadData();
    lstLongNumbers = getItems();
  }

  Future<void> loadData() async {
    lstMaxMissDays = await maxMissDayService.getByLotto(widget.lotto.id);
  }

  Future<List<LongNumber>> getItems() async {
    await Future.delayed(Duration(seconds: 3));
    return LottoHelper.getLongNumbers(
        widget.prizes, widget.lotto.min, widget.lotto.max, lstMaxMissDays);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LongNumber>>(
      future: lstLongNumbers,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<LongNumber>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            items = snapshot.data!;

            return Column(
              children: [                
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
                        padding:
                            const EdgeInsets.only(left: 0, right: 0, top: 10),
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
          } else {
            return const SizedBox();
          }
        } else {
          return Text('Thống kê theo ngày không ra');
        }
      },
    );
  }
}
