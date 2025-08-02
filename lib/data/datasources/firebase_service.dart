import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:votez/core/constants/app_constants.dart';
import 'package:votez/data/models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static String? getUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  // Register User
  Future<UserModel?> registerUser(UserModel userModel) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: userModel.password!,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection(AppConstants.userCollection).doc(user.uid).set({
          'name': userModel.name!,
          'email': userModel.email!,
          'createdAt': FieldValue.serverTimestamp(),
        });

        return UserModel.fromFirebaseUser(user);
      } else {
        throw Exception("User registration failed");
      }
    } catch (e) {
      print("Error registering user: $e");
      rethrow;
    }
  }

  // Login User
  Future<UserModel?> loginUser(UserModel userModel) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userModel.email!,
        password: userModel.password!,
      );

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        return UserModel.fromFirebaseUser(firebaseUser);
      } else {
        return null;
      }
    } catch (e) {
      print("Error logging in: $e");
      rethrow;
    }
  }

  // Add Data
  Future<void> addData(
    String collection,
    Map<String, dynamic> data,
    String? documentId,
  ) async {
    try {
      if (documentId != "") {
        await _firestore.collection(collection).doc(documentId).set(data);
      } else {
        await _firestore.collection(collection).add(data);
      }
    } catch (e) {
      print("Error adding document: $e");
      rethrow;
    }
  }

  // Delete Data
  Future<void> deleteData(String collection, String documentId) async {
    try {
      await _firestore.collection(collection).doc(documentId).delete();
    } catch (e) {
      print("Error deleting document: $e");
      rethrow;
    }
  }

  // Edit Data
  Future<void> updateData(String collection, String documentId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(documentId).update(data);
    } catch (e) {
      print("Error updating document: $e");
      rethrow;
    }
  }

  // Get Data
  Future<List<Map<String, dynamic>>> getData(String collection) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.collection(collection).get();

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print("Error fetching documents: $e");
      rethrow;
    }
  }

  // Get Filtered Data
  Future<List<Map<String, dynamic>>> getFilteredData(
    String collection,
    String field,
    String value,
  ) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection(collection).where(field, isEqualTo: value).get();

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print("Error fetching filtered documents: $e");
      rethrow;
    }
  }

  // get a Single Data
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

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print("Error signing out: $e");
      rethrow;
    }
  }
}
