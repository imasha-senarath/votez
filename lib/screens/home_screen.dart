import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void signOut() {
    FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Votez"),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
