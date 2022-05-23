import 'package:flutter/material.dart';
import '../../../models/lotto.dart';
import '../../../models/prize.dart';
import '../../../services/prize_service.dart';
import 'long_number_card.dart';
import 'lotto_suggest.dart';
import 'match_number_card.dart';
import 'triple_number_card.dart';

class LottoSunmaryCard extends StatefulWidget {
  final Lotto lotto;
  final DateTime drawtime;
  const LottoSunmaryCard(
      {Key? key, required this.lotto, required this.drawtime})
      : super(key: key);

  @override
  State<LottoSunmaryCard> createState() => _LottoSunmaryCardState();
}

class _LottoSunmaryCardState extends State<LottoSunmaryCard> {
  final itemService = PrizeService();

  late Future<List<Prize>> lstItems;

  @override
  initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    lstItems = itemService.getOldItems(widget.lotto.id, widget.drawtime, 60);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Prize>>(
      future: lstItems,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Prize>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Lỗi lấy dữ liệu từ hệ thống.');
          } else if (snapshot.hasData) {
            var items = snapshot.data!;
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                MatchNumberCard(prizes: items), 
                const SizedBox(
                  height: 10,
                ),
                LongNumberCard(lotto: widget.lotto, prizes: items),
                if (!widget.lotto.isball) ...[
                  TripleNumberCard(lotto: widget.lotto, prizes: items)
                ],   
                const SizedBox(
                  height: 10,
                ),
                LottoSuggest(
                  lotto: widget.lotto,
                  prizes: items.take(5).toList(),
                ),            
              ],
            );
          } else {
            return const SizedBox();
          }
        } else {
          return Text('Đang tải dữ liệu...');
        }
      },
    );
  }
}


