import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/lotto_helper.dart';
import 'prize_number.dart';

class Prize {
  String id;
  final String lotto;
  final String code;
  DateTime drawtime;
  String? numbers;
  String? json;
  final bool status;

  Prize({
    required this.lotto,
    required this.code,
    required this.drawtime,
    this.id = '',
    this.numbers = '',
    this.json = '',
    this.status = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lotto': lotto,
      'code': code,
      'drawtime': drawtime,
      'numbers': numbers,
      'json': json,
      'status': status,
    };
  }

  factory Prize.fromJson(Map<String, dynamic> json) {
    return Prize(
      id: json['id'],
      lotto: json['lotto'],
      code: json['code'],
      drawtime: (json['drawtime'] as Timestamp).toDate(),
      numbers: json['numbers'],
      json: json['json'],
      status: json['status'] ?? false,
    );
  }

  List<PrizeNumber> getPrizes() {
    var prizes = <PrizeNumber>[];
    if (json?.isNotEmpty ?? true) {
      Map<String, dynamic> data = jsonDecode(json!);
      var lstItems = data['root']['prizenumber'];
      if (lstItems == null) {
        return prizes;
      }      
      try {
        lstItems.forEach((v) {
          prizes.add(PrizeNumber.fromJson(v));
        });
      } catch (e) {
        prizes.add(PrizeNumber.fromJson(lstItems));
      }
    }
    return prizes;
  }

  String getNumbers() {
    var numbers = <String>[];
    if (json?.isNotEmpty ?? true) {
      getPrizes().forEach((element) {
        numbers.add(element.number);
      });
      return numbers.join(" ");
    }
    return '';
  }

  String getSerial() {
    return LottoHelper.getSerial(json);
  }
}
