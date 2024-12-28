import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:votez/auth/login_or_register.dart';
import 'package:votez/screens/home_screen.dart';
import 'package:votez/screens/main_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return const MainScreen();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
