import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getDocumentsByCollectionAndUid(
      String collectionName, String uid) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(collectionName)
          .where('uid', isEqualTo: uid)
          .get();

      return snapshot.docs;
    } catch (e) {
      throw e;
    }
  }
}
