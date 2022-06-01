class Lotto {
  String id;
  final String country;
  final String code;
  final String name;
  final int min;
  final int max;
  final String drawtime;
  final bool isball;

  Lotto({
    required this.country,
    required this.code,
    required this.name,
    required this.min,
    required this.max,
    this.drawtime = '',
    this.id = '',
    this.isball = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'country': country,
      'code': code,
      'name': name,
      'min': min,
      'max': max,
      'drawtime': drawtime,
      'isball': isball,
    };
  }

  factory Lotto.fromJson(Map<String, dynamic> json) {
    return Lotto(
      id: json['id'],
      country: json['country'],
      code: json['code'],
      name: json['name'],
      min: json['min'] ?? 0,
      max: json['max'] ?? 0,
      drawtime: json['drawtime'] ?? '',
      isball: json['isball'] ?? false,
    );
  }
}
