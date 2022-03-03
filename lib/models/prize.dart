import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'prize_number.dart';

class Prize {
  String id;
  final String lotto;
  final String code;
  DateTime drawtime;
  String? numbers;
  String? source;
  String? xml;
  String? json;

  Prize(
      {required this.lotto,
      required this.code,
      required this.drawtime,
      this.id = '',
      this.numbers = '',
      this.source = '',
      this.xml = '',
      this.json = ''});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lotto': lotto,
      'code': code,
      'drawtime': drawtime,
      'numbers': numbers,
      'source': source,
      'xml': xml,
      'json': json,
    };
  }

  factory Prize.fromJson(Map<String, dynamic> json) {
    return Prize(
      id: json['id'],
      lotto: json['lotto'],
      code: json['code'],
      drawtime: (json['drawtime'] as Timestamp).toDate(),
      numbers: json['numbers'],
      source: json['source'],
      xml: json['xml'],
      json: json['json'],
    );
  }

  // List<PrizeNumber> getPrizeNumbers() {
  //   var prizes = <PrizeNumber>[];
  //   if (json?.isNotEmpty ?? true) {
  //     Map<String, dynamic> data = jsonDecode(json!);
  //     var lstItems = data['root']['prizenumber'];
  //     if (lstItems == null) {
  //       return prizes;
  //     }
  //     try {
  //       lstItems.forEach((v) {
  //         prizes.add(PrizeNumber.fromJson(v));
  //       });
  //     } catch (e) {
  //       prizes.add(PrizeNumber.fromJson(lstItems));
  //     }
  //   }
  //   return prizes;
  // }
  
}


