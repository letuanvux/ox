import 'package:cloud_firestore/cloud_firestore.dart';

class Contest {  
  final String lotto;
  final String title; 
  final DateTime? fromdate;
  final DateTime? todate; 
  final String details;  
  final String? imgUrl;
  final String? tags;
  final int views;
  String id;

  Contest({
    required this.lotto,
    required this.title,
    required this.details,
    this.fromdate,
    this.todate,
    this.imgUrl = '',
    this.tags,
    this.views = 0,
    this.id = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'lotto': lotto,
      'title': title,
      'details': details,
      'fromdate': fromdate,
      'imgUrl': imgUrl, 
      'todate': todate,    
      'tags': tags,     
      'views': views,
    };
  }

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      id: json['id'],
      lotto: json['lotto'],
      title: json['title'],
      details: json['details'],
      fromdate: json['fromdate'] != null ? (json['fromdate'] as Timestamp).toDate() : null,
      todate: json['todate'] != null ? (json['todate'] as Timestamp).toDate() : null,
      imgUrl: json['imgUrl'] ?? '',
      tags: json["tags"],
      views: json['views'] ?? 0,
    );
  }

  Contest.fromMap(Map<String, dynamic> map, {required this.id})
      : lotto = map['lotto'],
        title = map['title'],
        details = map['details'],
        fromdate = map['fromdate'] != null ? (map['fromdate'] as Timestamp).toDate() : null,
        todate = map['todate'] != null ? (map['todate'] as Timestamp).toDate() : null,
        imgUrl = map['imgUrl'],
        tags = map["tags"],        
        views = map['views'];

  Contest.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data() as Map<String, dynamic>, id: snapshot.id);
}
