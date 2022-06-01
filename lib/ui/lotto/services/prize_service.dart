import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/prize.dart';

class PrizeService {
  final collects = FirebaseFirestore.instance.collection("prizes");

  //Set method can be used to update or add records,
  // when updating all existing data will be overwritten
  Future<void> setItem(Prize item) async {
    collects.doc(item.id).set(item.toMap());
  }

  //Update just instructor field, merge into existing data
  Future<void> setItemMerge(String id, String name) async {
    var options = SetOptions(merge: true);
    collects.doc(id).set({'name': name}, options);
  }

  //Add course with default firebase id, then update record with id
  Future<void> addItem(Prize item) async {
    var documentRef = await collects.add(item.toMap());
    var createdId = documentRef.id;
    // update id
    collects.doc(createdId).update(
      {'id': createdId},
    );
  }

  //Update entire course, any existing data will be merged
  Future<void> updateItem(Prize item) async {
    collects.doc(item.id).update(item.toMap());
  }

  Future<void> deleteItem(String id) async {
    await collects.doc(id).delete();
  }

  //Get all records from collection as Stream
  Stream<List<Prize>> getAllStream() {
    return collects.snapshots().map((snapshot) => snapshot.docs
        .map((document) => Prize.fromJson(document.data()))
        .toList());
  }

  //Get all records from collection as Future
  Future<List<Prize>> getAllFuture() {
    return collects.get().then((snapshot) => snapshot.docs
        .map((document) => Prize.fromJson(document.data()))
        .toList());
  }

  //Get one record from Id as Stream
  Stream<Prize> getOneStream(String id) {
    return collects
        .doc(id)
        .snapshots()
        .map((snapshot) => Prize.fromJson(snapshot.data()!));
  }

  //Get one record from Id as Future
  Future<Prize> getOneFuture(String id) {
    return collects
        .doc(id)
        .get()
        .then((snapshot) => Prize.fromJson(snapshot.data()!));
  }

  Future<Prize?> getByCode(String lotto, String code) {
    return collects
        .where('lotto', isEqualTo: lotto)
        .where('code', isEqualTo: code)
        .limit(1)
        .get()
        .then((snapshot) => snapshot.docs.isEmpty
            ? null
            : Prize.fromJson(snapshot.docs[0].data()));
  }

  Future<Prize?> getLastest(String lotto) {
    return collects
        .where('lotto', isEqualTo: lotto)
        .orderBy('drawtime', descending: true)
        .orderBy('code', descending: true)
        .limit(1)
        .get()
        .then((snapshot) => snapshot.docs.isEmpty
            ? null
            : Prize.fromJson(snapshot.docs[0].data()));
  }

  //Get all courses for instructor as Stream
  Stream<List<Prize>> whereAsStream(String lotto) {
    return collects.where('lotto', isEqualTo: lotto).snapshots().map(
        (snapshot) => snapshot.docs
            .map((document) => Prize.fromJson(document.data()))
            .toList());
  }

  Future<List<Prize>> getByLotto(String lotto) {
    return collects
        .where('lotto', isEqualTo: lotto)
        .orderBy('drawtime', descending: true)
        .orderBy('code', descending: true)
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => Prize.fromJson(document.data()))
            .toList());
  }

  Future<List<Prize>> getOldItems(String lotto, DateTime drawtime, int limit) {
    return collects
        .where('lotto', isEqualTo: lotto)
        .where('drawtime', isLessThan: drawtime)
        .orderBy('drawtime', descending: true)
        .orderBy('code', descending: true)
        .limit(limit)
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => Prize.fromJson(document.data()))
            .toList());
  }

  Future<List<Prize>> getByDate(DateTime drawtime) {    
    return collects
        .where('drawtime', isEqualTo: drawtime)
        .orderBy('code', descending: true)
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => Prize.fromJson(document.data()))
            .toList());
  }

  //Get all courses for instructor as Future
  Future<List<Prize>> whereAsFuture(String lotto) {
    return collects.where('lotto', isEqualTo: lotto).get().then((snapshot) =>
        snapshot.docs
            .map((document) => Prize.fromJson(document.data()))
            .toList());
  }

  //Order all results by instructor
  Stream<List<Prize>> orderByName(String lotto) {
    return collects
        .where('lotto', isEqualTo: lotto)
        .orderBy('code', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Prize.fromJson(document.data()))
            .toList());
  }

  Future<List<Prize>> limitResults(String lotto, int limit) {
    return collects
        .where('lotto', isEqualTo: lotto)
        .orderBy('drawtime', descending: true)
        .orderBy('code', descending: true)
        .limit(limit)
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => Prize.fromJson(document.data()))
            .toList());
  }

  Stream<List<Prize>> paging(String lotto, int page, {int limit = 10}) {
    return collects
        .where('lotto', isEqualTo: lotto)
        .orderBy('drawtime', descending: true)
        .orderBy('code', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .skip(limit * (page - 1))
            .take(limit)
            .map((document) => Prize.fromJson(document.data()))
            .toList());
  }

  Future<List<Prize>> search(String lotto, int page, {int limit = 10}) async {
    var items = paging(lotto, page, limit: limit);
    return items.first;
  }
}
