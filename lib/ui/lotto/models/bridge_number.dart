class BridgeNumber {
  int group;
  int position;
  int index;

  BridgeNumber({
    required this.group,
    required this.position,
    required this.index,
  });

  factory BridgeNumber.fromJson(Map<String, dynamic> json) {
    return BridgeNumber(
      group: int.parse(json['group'] ?? '0'),
      position: int.parse(json['position'] ?? '0'),
      index: int.parse(json['index'] ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group'] = group;
    data['position'] = position;
    data['index'] = position;
    return data;
  }
  
  String getLocation() {
    return "⌜G${group}P${position}I${index}⌟";
  }
}