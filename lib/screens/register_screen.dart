import 'package:flutter/material.dart';

import '../components/app_dialog.dart';
import '../components/app_button.dart';
import '../components/text_field.dart';
import '../services/firebase_service.dart';
import '../utils/constants/app_assets.dart';
import '../utils/constants/sizes.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onTap;

  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseService _firebase = FirebaseService();

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  late String name;
  late String email;
  late String password;

  void validation() {
    name = nameTextController.text;
    email = emailTextController.text;
    password = passwordTextController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      AppDialog.showToast(context: context, message: "Field's can't be empty.");
    } else {
      register();
    }
  }

  void register() async {
    AppDialog.showLoading(context: context);

    String? error = await _firebase.registerUser(email, password, name);

    if (error != null) {
      AppDialog.hideDialog(context);
      AppDialog.showErrorDialog(context: context, message: error);
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
                  onTap: () {
                    validation();
                  },
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
