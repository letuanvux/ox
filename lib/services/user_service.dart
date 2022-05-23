import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserService {
  final collects = FirebaseFirestore.instance.collection("users");

  Future<void> addNewItem(User item) {
    return collects.add(item.toJson());
  }

  Future<void> updateItem(User item) {
    return collects.doc(item.id).update(item.toJson());
  }

  Future<void> deleteItem(String id) async {
    await collects.doc(id).delete();
  }

  Stream<List<User>> getAll() {
    return collects.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<User>> search(String country, String keyword, int page) {
    return collects
        .where('name', isEqualTo: country.toLowerCase())
        .snapshots()
        .skip(10 * (page - 1))
        .take(10)
        .map((snapshot) {
      return snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  Future<List<User>> paging(String keyword, int page) {
    return collects
        .where('name', isEqualTo: keyword.toLowerCase())
        .snapshots()
        .skip(10 * (page - 1))
        .take(10)
        .first
        .then((snapshot) {
      return snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  void createUser(String uid, String name, String email, String phone) {
    collects.add({
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "votes": 0,
      "rating": 0,
    });
  }

  Future updateUserData(Map<String, dynamic> values) async {
    await collects.doc(values['id']).update(values);
  }

  Future<User> getUserById(String id) => collects.doc(id).get().then((doc) {
        return User.fromSnapshot(doc);
      });

  Future<User?> getByEmail(String email) {
    return collects
        .where('email', isEqualTo: email.toLowerCase())
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      } else {
        return User.fromSnapshot(snapshot.docs[0]);
      }
    });
  }

  Future<bool> isExistedEmail(String email) {
    return collects
        .where('email', isEqualTo: email.toLowerCase())
        .limit(1)
        .get()
        .then((snapshot) {
      return snapshot.docs.isNotEmpty ? true : false;
    });
  }

  void addDeviceToken(String token, String userId) {
    collects.doc(userId).update({"token": token});
  }
}
