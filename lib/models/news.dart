import 'package:cloud_firestore/cloud_firestore.dart';

class News {  
  final String title;
  final String content;  
  final String tags;
  final int views;
  final String id;

  News({
    required this.title,
    required this.content,
    required this.tags,
    this.views = 0,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,      
      'tags': tags,
      'views': views,
    };
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      tags: json['tags'],
      views: json['views'] ?? 0,
    );
  }

  News.fromMap(Map<String, dynamic> map, {required this.id})
      : title = map['title'],
        content = map['content'],
        tags = map['tags'],
        views = map['views'];

  News.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data() as Map<String, dynamic>, id: snapshot.id);
}
