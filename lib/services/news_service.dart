import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/news.dart';

class NewsService {
  final collects = FirebaseFirestore.instance.collection("news");

  Future<void> addNewItem(News item) {
    return collects.add(item.toJson());
  }

  Future<void> updateItem(News item) {
    return collects.doc(item.id).update(item.toJson());
  }

  Future<void> deleteItem(String id) async {
    await collects.doc(id).delete();
  }

  Stream<List<News>> getAll() {
    return collects.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => News.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<News>> search(String country, String keyword, int page) {
    return collects
        .where('country', isEqualTo: country.toLowerCase())
        .snapshots()
        .skip(10 * (page - 1))
        .take(10)
        .map((snapshot) {
      return snapshot.docs.map((doc) => News.fromSnapshot(doc)).toList();
    });
  }

  Future<List<News>> paging(String keyword, int page) {
    return collects
      .where('title', isEqualTo: keyword.toLowerCase())
      .snapshots()
      .skip(10 * (page - 1))
      .take(10)
      .first
      .then((snapshot) {
        return snapshot.docs.map((doc) => News.fromSnapshot(doc)).toList();
      });
  }
}
