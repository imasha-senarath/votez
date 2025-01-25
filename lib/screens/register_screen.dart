import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/text_field.dart';
import '../utils/constants/app_assets.dart';
import '../utils/constants/sizes.dart';

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
                  "Let's get started",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "Let's create an account for you",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  textEditingController: nameTextController,
                  labelText: "Name",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  textEditingController: nicTextController,
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
    );
  }
}
