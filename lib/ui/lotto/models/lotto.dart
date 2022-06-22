class Lotto {
  String id;
  final String country;
  final String code;
  final String name;
  final String imgUrl;
  final int min;
  final int max;
  final String drawtime;
  final bool isball;
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
    this.imgUrl = '',
    this.drawtime = '',
    this.id = '',
    this.isball = false,
    this.rating = 0,
    this.noOfRating = 0,
    this.isFavorite = false,
    this.isFeatured = false,
    this.color = '',
    this.gradient = '',
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
      min: json['min'] ?? 0,
      max: json['max'] ?? 0,
      drawtime: json['drawtime'] ?? '',
      isball: json['isball'] ?? false,
      rating: json['rating'] ?? 0,
      noOfRating: json['noOfRating'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      color: json['color'] ?? '',
      gradient: json['gradient'] ?? '',
    );
  }
}
