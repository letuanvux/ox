class MaxMissDay {
  String id;
  final String lotto;
  final String number;
  final int maxdays;

  MaxMissDay({
    required this.lotto,
    required this.number,
    required this.maxdays,
    this.id = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lotto': lotto,
      'number': number,
      'maxdays': maxdays,      
    };
  }

  factory MaxMissDay.fromJson(Map<String, dynamic> json) {
    return MaxMissDay(
      id: json['id'],
      lotto: json['lotto'],
      number: json['number'],
      maxdays: json['maxdays'] ?? 0,      
    );
  }
}
