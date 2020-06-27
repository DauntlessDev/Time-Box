import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  FirestoreService._();
  static FirestoreService intance = FirestoreService._();

  Stream<List<T>> collectionStream<T>(
      {@required path,
      @required T builder(Map<String, dynamic> data, String documentID)}) {
    final CollectionReference documentReference =
        Firestore.instance.collection(path);
    final Stream<QuerySnapshot> snapshots = documentReference.snapshots();
    return snapshots.map(
      (snapshot) => snapshot.documents
          .map((snapshot) => builder(snapshot.data, snapshot.documentID))
          .toList(),
    );
  }

  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final documentReference = Firestore.instance.document(path);
    debugPrint('$path : $data');

    try {
      await documentReference.setData(data);
    } catch (e) {
      throw PlatformException(
          code: 'PERMISSION_DENIED',
          message: 'User has insufficient permission for the action.');
    }
  }
}
