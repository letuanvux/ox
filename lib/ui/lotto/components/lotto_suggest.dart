import 'package:flutter/material.dart';
import '../helpers/lotto_helper.dart';

import '../models/lotto.dart';
import '../models/prize.dart';
import '../services/prize_service.dart';
import 'number_card.dart';

class LottoSuggest extends StatefulWidget {
  final Lotto lotto;
  final List<Prize> prizes;
  const LottoSuggest({Key? key, required this.lotto, required this.prizes}) : super(key: key);

  @override
  State<LottoSuggest> createState() => _LottoSuggestState();
}

class _LottoSuggestState extends State<LottoSuggest> {
  final prizeService = PrizeService();
  late List<String> lstNumbers = [];

  Future<void> loadData() async {
    // Lay danh sach du doan
    lstNumbers = LottoHelper.getRandom(widget.lotto.max);
    if (widget.lotto.min == 0) {
      lstNumbers.insert(0, '00');
    }    
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var lstMatchs = [];
    var lstGroup = [];
    //Kiem tra nhung so da ra
    for (var i = 0; i < widget.prizes.length; i++) {
      if (i > 1 && i <= 3) {
        List<String> numbers = widget.prizes[i].numbers!.split(' ');
        for (String number in numbers) {
          number = number.substring(number.length - 2);
          lstNumbers.remove(number);
          lstMatchs.add(number);
        }
      }
    }
    // Count same numbers
    lstMatchs.forEach((item) {
      int id = lstGroup.indexWhere((value) => value['number'] == item);
      if (id < 0) {
        lstGroup.add({'number': item, 'count': 1});
      } else {
        lstGroup[id]['count'] += 1;
      }
    });
    lstGroup = lstGroup.where((element) => element['count'] == 2).toList();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: GridView.count(
              crossAxisCount: 10,
              mainAxisSpacing: 2,
              shrinkWrap: true,
              crossAxisSpacing: 2,
              children: lstNumbers.map((String number) {
                return NumberCard(
                  number: number,
                  color: Colors.red,
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            child: GridView.count(
              crossAxisCount: 10,
              mainAxisSpacing: 2,
              shrinkWrap: true,
              crossAxisSpacing: 2,
              children: lstGroup.map((item) {
                return NumberCard(number: item['number'], color: Colors.orange);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
