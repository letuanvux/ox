import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/lotto.dart';

class LottoService {
  final collects = FirebaseFirestore.instance.collection("lottos");

  //Set method can be used to update or add records,
  // when updating all existing data will be overwritten
  Future<void> setItem(Lotto item) async {
    collects.doc(item.id).set(item.toJson());
  }

  //Update just instructor field, merge into existing data
  Future<void> setItemMerge(String id, String code) async {
    var options = SetOptions(merge: true);
    collects.doc(id).set({'code': code}, options);
  }

  Future<void> setStatus(String id, bool status) async {
    var options = SetOptions(merge: true);
    collects.doc(id).set({'status': status}, options);
  }

  //Add course with default firebase id, then update record with id
  Future<void> addItem(Lotto item) async {
    final docItem = collects.doc();
    item.id = docItem.id;
    await docItem.set(item.toJson());
  }

  //Update entire course, any existing data will be merged
  Future<void> updateItem(Lotto item) async {
    collects.doc(item.id).update(item.toJson());
  }

  Future<void> updateTotalPrizes(String id, int total) async {
    collects.doc(id).update({'totalPrizes': total});
  }

  Future<void> updateSummary(
      String id, String minCode, String maxCode, int total) async {
    collects
        .doc(id)
        .update({'minCode': minCode, 'maxCode': maxCode, 'totalPrizes': total});
  }

  Future<void> deleteItem(String id) async {
    await collects.doc(id).delete();
  }

  Stream<List<Lotto>> search(String country, String keyword, int page) {
    return collects
        .where('country', isEqualTo: country.toLowerCase())
        .snapshots()
        .skip(10 * (page - 1))
        .take(10)
        .map((snapshot) => snapshot.docs
            .map((document) => Lotto.fromJson(document.data()))
            .toList());
  }

  //Get all records from collection as Stream
  Stream<List<Lotto>> getAllStream() {
    return collects.snapshots().map((snapshot) => snapshot.docs
        .map((document) => Lotto.fromJson(document.data()))
        .toList());
  }

  //Get all records from collection as Future
  Future<List<Lotto>> getAllFuture() {
    return collects.get().then((snapshot) => snapshot.docs
        .map((document) => Lotto.fromJson(document.data()))
        .toList());
  }

  //Get one record from Id as Stream
  Stream<Lotto> getOneStream(String id) {
    return collects
        .doc(id)
        .snapshots()
        .map((snapshot) => Lotto.fromJson(snapshot.data()!));
  }

  //Get one record from Id as Future
  Future<Lotto> getOneFuture(String id) {
    return collects
        .doc(id)
        .get()
        .then((snapshot) => Lotto.fromJson(snapshot.data()!));
  }

  //Get all courses for instructor as Stream
  Stream<List<Lotto>> whereAsStream(String name) {
    return collects.where('name', isEqualTo: name).snapshots().map((snapshot) =>
        snapshot.docs
            .map((document) => Lotto.fromJson(document.data()))
            .toList());
  }

  //Get all courses for instructor as Future
  Future<List<Lotto>> whereAsFuture(String name) {
    return collects.where('name', isEqualTo: name).get().then((snapshot) =>
        snapshot.docs
            .map((document) => Lotto.fromJson(document.data()))
            .toList());
  }

  //Order all results by instructor
  Stream<List<Lotto>> orderByNumberMax() {
    return collects.orderBy('number_max', descending: true).snapshots().map(
        (snapshot) => snapshot.docs
            .map((document) => Lotto.fromJson(document.data()))
            .toList());
  }

  //Limit Results to parameter value
  Stream<List<Lotto>> limitResults(int limitBy) {
    return collects.limit(limitBy).snapshots().map((snapshot) => snapshot.docs
        .map((document) => Lotto.fromJson(document.data()))
        .toList());
  }

  
}
