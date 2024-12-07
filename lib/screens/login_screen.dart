import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:votez/components/button.dart';
import 'package:votez/components/text_field.dart';

import '../components/dialog.dart';

class LoginScreen extends StatefulWidget {
  final Function() onTap;

  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailTextController.text, password: passwordTextController.text);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialog(
              title: 'Error',
              description: e.code,
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 100,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    "Welcome Back to Votez",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    "Vote Anytime, Anywhere Online",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextField(
                    textEditingController: emailTextController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    textEditingController: passwordTextController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyButton(
                    onTap: login,
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
      ),
    );
  }
}
