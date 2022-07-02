class Lotto {
  String id;
  final String country;
  final String code;
  final String name;
  final String imgUrl;
  final int min;
  final int max;
  final int totalPrizes;
  final dynamic drawdays;
  final String drawtime;
  final bool isball;
  final bool status;
  final String minCode;
  final String maxCode;
  final int rating;
  final int noOfRating;
  final bool isFavorite;
  final bool isFeatured;
  final String color;
  final String gradient;

  Lotto({
    required this.country,
    required this.code,
    required this.name,
    required this.min,
    required this.max,
    this.totalPrizes = 0,
    this.imgUrl = '',
    this.drawdays = const [],
    this.drawtime = '',
    this.id = '',
    this.isball = false,
    this.status = false,
    this.minCode = '',
    this.maxCode = '',
    this.rating = 0,
    this.noOfRating = 0,
    this.isFavorite = false,
    this.isFeatured = false,
    this.color = '',
    this.gradient = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'code': code,
      'name': name,
      'imgUrl': imgUrl,
      'min': min,
      'max': max,
      'totalPrizes': totalPrizes,
      'drawdays': drawdays,
      'drawtime': drawtime,
      'isball': isball,
      'status': status,
      'minCode': minCode,
      'maxCode': maxCode,
      'rating': rating,
      'noOfRating': noOfRating,
      'isFavorite': isFavorite,
      'isFeatured': isFeatured,
      'color': color,
      'gradient': gradient,
    };
  }

  factory Lotto.fromJson(Map<String, dynamic> json) {
    return Lotto(
      id: json['id'],
      country: json['country'],
      code: json['code'],
      name: json['name'],
      imgUrl: json['imgUrl'] ?? '',
      min: json['min'] ?? 0,
      max: json['max'] ?? 0,
      totalPrizes: json['totalPrizes'] ?? 0,
      drawdays: json['drawdays']  ?? [],
      drawtime: json['drawtime'] ?? '',
      isball: json['isball'] ?? false,
      status: json['status'] ?? false,
      minCode: json['minCode'] ?? '',
      maxCode: json['maxCode'] ?? '',
      rating: json['rating'] ?? 0,
      noOfRating: json['noOfRating'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      color: json['color'] ?? '',
      gradient: json['gradient'] ?? '',
    );
  }
}
