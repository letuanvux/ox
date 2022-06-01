import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import '../helpers/lotto_helper.dart';
import '../models/long_number.dart';
import '../models/prize.dart';
import 'number_card.dart';

class MatchNumberCard extends StatefulWidget {
  final List<Prize> prizes;
  const MatchNumberCard({
    Key? key,
    required this.prizes,
  }) : super(key: key);

  @override
  State<MatchNumberCard> createState() => _MatchNumberCardState();
}

class _MatchNumberCardState extends State<MatchNumberCard> {
  late List<MatchNumber> items = [];
  late Future<List<MatchNumber>> lstLongNumbers;

  Future<void> loadData() async {
    // Lay danh sach du doan
    lstLongNumbers = LottoHelper.getDayNumbers(widget.prizes);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MatchNumber>>(
      future: lstLongNumbers,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<MatchNumber>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            items = snapshot.data!;
            return Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 8.0,
              textDirection: TextDirection.ltr,
              children: items.map((MatchNumber item) {
                  return Badge(
                    badgeContent: Text('${item.days}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13)),
                    badgeColor: Colors.orange,
                    child: NumberCard(
                      number: item.number,
                      color: Colors.orange,
                    ),
                  );
                }).toList(),
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
