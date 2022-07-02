import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/max_miss_day.dart';

class MaxMissDayService {
  final collects = FirebaseFirestore.instance.collection("maxmissdays");

  //Set method can be used to update or add records,
  // when updating all existing data will be overwritten
  Future<void> setItem(MaxMissDay item) async {
    collects.doc(item.id).set(item.toJson());
  }

  //Update just instructor field, merge into existing data
  Future<void> setItemMerge(String id, String code) async {
    var options = SetOptions(merge: true);
    collects.doc(id).set({'code': code}, options);
  }

  //Add course with default firebase id, then update record with id
  Future<void> addItem(MaxMissDay item) async {
    final docItem = collects.doc();
    item.id = docItem.id;
    await docItem.set(item.toJson());
  }

  //Update entire course, any existing data will be merged
  Future<void> updateItem(MaxMissDay item) async {
    collects.doc(item.id).update(item.toJson());
  }

  Future<void> deleteItem(String id) async {
    await collects.doc(id).delete();
  }

  Future<void> updateByLotto(String lotto, List<MaxMissDay> items) async {
    var doc = await collects.where('lotto', isEqualTo: lotto).get();
    doc.docs.forEach((element) => {deleteItem(element.id)});
    for (var item in items) {
      await addItem(item);
    }    
  }

  Future<List<MaxMissDay>> getByLotto(String lotto) {
    return collects.where('lotto', isEqualTo: lotto).get().then((snapshot) =>
        snapshot.docs
            .map((document) => MaxMissDay.fromJson(document.data()))
            .toList());
  }
}
