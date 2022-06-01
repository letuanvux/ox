class PrizeNumber {
  int group;
  int position;
  String number;
  bool isoption;

  PrizeNumber(
      {required this.group,
      required this.position,
      required this.number,
      this.isoption = false});

  factory PrizeNumber.fromJson(Map<String, dynamic> json) {
    return PrizeNumber(
      group: int.parse(json['group'] ?? '0'),
      position: int.parse(json['position'] ?? '0'),
      number: json['number'],
      isoption: json['isoption'] =='true' ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group'] = group;
    data['position'] = position;
    data['number'] = number;
    data['isoption'] = isoption;
    return data;
  }
  
}
