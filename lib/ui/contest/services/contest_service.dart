import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contest.dart';

class ContestService {
  final collects = FirebaseFirestore.instance.collection("contests");

  Future<void> addItem(Contest item) {
    return collects.add(item.toJson());
  }

  Future<void> updateItem(Contest item) {
    return collects.doc(item.id).update(item.toJson());
  }

  Future<void> deleteItem(String id) async {
    await collects.doc(id).delete();
  }

  Stream<List<Contest>> getAll() {
    return collects.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Contest.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Contest>> search(String keyword, int page) {
    return collects
        .where('title', isGreaterThanOrEqualTo: keyword.toLowerCase())
        .where('title', isLessThanOrEqualTo: '${keyword.toLowerCase()}\uf8ff')
        .snapshots()
        .skip(10 * (page - 1))
        .take(10)
        .map((snapshot) {
      return snapshot.docs.map((doc) => Contest.fromSnapshot(doc)).toList();
    });
  }

  Future<List<Contest>> paging(String keyword, int page) {
    return collects
      .where('title', isGreaterThanOrEqualTo: keyword.toLowerCase())
      .where('title', isLessThanOrEqualTo: '${keyword.toLowerCase()}\uf8ff')
      .snapshots()
      .skip(10 * (page - 1))
      .take(10)
      .first
      .then((snapshot) {
        return snapshot.docs.map((doc) => Contest.fromSnapshot(doc)).toList();
      });
  }  
}
