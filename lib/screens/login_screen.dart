import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:votez/components/app_button.dart';
import 'package:votez/components/text_field.dart';
import 'package:votez/utils/constants/app_assets.dart';


import '../components/app_dialog.dart';
import '../utils/constants/sizes.dart';

class LoginScreen extends StatefulWidget {
  final Function() onTap;

  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void validation()  {
    /*addData(
      'Users',
      {'name': 'Imasha Senarath', 'email': 'contact@imasha.com'},
    );*/

    var email = emailTextController.text;
    var password = passwordTextController.text;

    if(email.isEmpty || password.isEmpty) {
      AppDialog.showToast(context: context, message: "Field's can't be empty.");
    } else {
      login();
    }
  }

  void login() async {
    AppDialog.showLoading(context: context);

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailTextController.text, password: passwordTextController.text);
      AppDialog.hideDialog(context);
    } on FirebaseAuthException catch (e) {
      AppDialog.hideDialog(context);
      AppDialog.showErrorDialog(context: context, message: e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Image(
                  image: AssetImage(AppAssets.appLogo),
                  width: 80,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome back!",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "Vote Anytime, Anywhere Online",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  textEditingController: emailTextController,
                  labelText: "Email",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  textEditingController: passwordTextController,
                  labelText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                AppButton(
                  onTap: validation,
                  text: "Login",
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection(collection).add(data);
      AppDialog.showToast(context: context, message: "success");
    } catch (e) {
      AppDialog.showErrorDialog(context: context, message: e.toString());
      print("Error adding document: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getData(String collection) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      final querySnapshot = await firestore.collection(collection).get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      print("Error getting documents: $e");
      rethrow;
    }
  }

  Future<void> updateData(String collection, String documentId, Map<String, dynamic> data) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection(collection).doc(documentId).update(data);
    } catch (e) {
      print("Error updating document: $e");
      rethrow;
    }
  }

  Future<void> deleteData(String collection, String documentId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection(collection).doc(documentId).delete();
    } catch (e) {
      print("Error deleting document: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getSingleData(String collection, String documentId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await firestore.collection(collection).doc(documentId).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        print("No such document!");
        return null;
      }
    } catch (e) {
      print("Error fetching document: $e");
      rethrow;
    }
  }
}
