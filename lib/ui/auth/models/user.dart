import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String name;
  final String id;

  User({
    required this.uid,
    required this.email,
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
    );
  }

  User.fromMap(Map<String, dynamic> map, {required this.id})
      : uid = map['uid'],
        email = map['email'],
        name = map['name'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, id: snapshot.id);
}
