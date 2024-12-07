import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/text_field.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onTap;

  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameTextController = TextEditingController();
  final nicTextController = TextEditingController();
  final passwordTextController = TextEditingController();

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
                  const Text(
                    "Let's create an account for you ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextField(
                    textEditingController: nameTextController,
                    hintText: "Name",
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    textEditingController: nicTextController,
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
                    onTap: () {},
                    text: "Register",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login",
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
