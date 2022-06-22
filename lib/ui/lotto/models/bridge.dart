import 'package:cloud_firestore/cloud_firestore.dart';

import 'bridge_number.dart';

class LottoBridge {
  String id;
  final String lotto;
  final DateTime drawtime;
  BridgeNumber? option;
  late BridgeNumber prefix;
  late BridgeNumber suffix;
  late String number;
  late String nextnumber;
  late int days;
  late int times;
  late bool isHasBridge;
  late DateTime fromtime;

  LottoBridge({
    required this.lotto,
    required this.drawtime,
    this.id = '',
    this.isHasBridge = false,    
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lotto': lotto,
      'drawtime': drawtime,
      'option': option,
      'prefix': prefix,
      'suffix': suffix,
      'days': days,
    };
  }

  factory LottoBridge.fromJson(Map<String, dynamic> json) {
    var item = LottoBridge(
      id: json['id'],
      lotto: json['lotto'],
      drawtime: (json['drawtime'] as Timestamp).toDate(),
    );
    item.option = json['option'];
    item.prefix = json['prefix'];
    item.suffix = json['suffix'];
    item.days = int.parse(json['days'] ?? '0');
    return item;
  }
}
