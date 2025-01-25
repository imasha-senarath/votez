import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static String? getUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  /// Add Data with Custom Document ID
  Future<void> addData(
    String collection,
    Map<String, dynamic> data, {
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        await _firestore.collection(collection).doc(documentId).set(data);
      } else {
        await _firestore.collection(collection).add(data);
      }
    } catch (e) {
      print("Error adding document: $e");
      rethrow;
    }
  }

  /// Delete Data
  Future<void> deleteData(String collection, String documentId) async {
    try {
      await _firestore.collection(collection).doc(documentId).delete();
    } catch (e) {
      print("Error deleting document: $e");
      rethrow;
    }
  }

  /// Edit Data
  Future<void> updateData(String collection, String documentId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(documentId).update(data);
    } catch (e) {
      print("Error updating document: $e");
      rethrow;
    }
  }

  /// Fetch All Data
  Future<List<Map<String, dynamic>>> getData(String collection) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.collection(collection).get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching documents: $e");
      rethrow;
    }
  }

  /// Fetch a Single Document by ID
  Future<Map<String, dynamic>?> getSingleData(String collection, String documentId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firestore.collection(collection).doc(documentId).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        return null;
      }

    } catch (e) {
      rethrow;
    }
  }
}
