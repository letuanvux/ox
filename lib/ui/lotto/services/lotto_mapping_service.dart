import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/lotto_mapping.dart';

class LottoMappingService {  
  final collects = FirebaseFirestore.instance.collection("lotto_mappings");

  //Set method can be used to update or add records,
  // when updating all existing data will be overwritten
  Future<void> setItem(LottoMapping item) async {
    collects.doc(item.id).set(item.toJson());
  }

  //Update just instructor field, merge into existing data
  Future<void> setItemMerge(String id, String name) async {
    var options = SetOptions(merge: true);
    collects.doc(id).set({'name': name}, options);
  }

  //Add course with default firebase id, then update record with id
  Future<void> addItem(LottoMapping item) async {
    final docItem = collects.doc();
    item.id = docItem.id;
    await docItem.set(item.toJson());
  }

  //Update entire course, any existing data will be merged
  Future<void> updateItem(LottoMapping item) async {
    collects.doc(item.id).update(item.toJson());
  }
 
  Future<void> deleteItem(String id) async {
    await collects.doc(id).delete();
  }

  //Get all records from collection as Stream
  Stream<List<LottoMapping>> getAllStream() {
    return collects.snapshots().map((snapshot) => snapshot.docs
        .map((document) => LottoMapping.fromJson(document.data()))
        .toList());
  }

  //Get all records from collection as Future
  Future<List<LottoMapping>> getAllFuture() {
    return collects.get().then((snapshot) => snapshot.docs
        .map((document) => LottoMapping.fromJson(document.data()))
        .toList());
  }

  //Get one record from Id as Stream
  Stream<LottoMapping> getOneStream(String id) {
    return collects.doc(id).snapshots()
        .map((snapshot) => LottoMapping.fromJson(snapshot.data()!));
  }

  //Get one record from Id as Future
  Future<LottoMapping> getOneFuture(String id) {
    return collects.doc(id).get()
        .then((snapshot) => LottoMapping.fromJson(snapshot.data()!));
  }

  //Get all courses for instructor as Stream
  Stream<List<LottoMapping>> whereAsStream(String lottoId) {
    return collects.where('lotto_id', isEqualTo: lottoId)
        .snapshots().map((snapshot) => snapshot.docs
            .map((document) => LottoMapping.fromJson(document.data()))
            .toList());
  }

  //Get all courses for instructor as Future
  Future<List<LottoMapping>> whereAsFuture(String lottoId) {
    return collects.where('lotto_id', isEqualTo: lottoId)
        .get().then((snapshot) => snapshot.docs
            .map((document) => LottoMapping.fromJson(document.data()))
            .toList());
  }

  //Order all results by instructor
  Stream<List<LottoMapping>> orderByName(String lottoId) {
    return collects.where('lotto_id', isEqualTo: lottoId)
        .orderBy('name', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => LottoMapping.fromJson(document.data()))
            .toList());
  }

  //Limit Results to parameter value
  Stream<List<LottoMapping>> limitResults(String lottoId, int limitBy) {
    return collects.where('lotto_id', isEqualTo: lottoId)
        .limit(limitBy).snapshots().map(
        (snapshot) => snapshot.docs
            .map((document) => LottoMapping.fromJson(document.data()))
            .toList());
  }
}