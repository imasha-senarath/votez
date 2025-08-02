import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/presentation/blocs/register/register_bloc.dart';
import 'package:votez/presentation/blocs/register/register_event.dart';
import 'package:votez/presentation/blocs/register/register_state.dart';

import '../../core/di/dependency_injection.dart';
import '../../core/widgets/app_dialog.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/text_field.dart';
import '../../data/datasources/firebase_service.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/sizes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterBloc _bloc = injection<RegisterBloc>();

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  late String name;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => _bloc,
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is UserRegisterSuccessState) {
                AppDialog.hideDialog(context);
              } else if (state is UserRegisterFailedState) {
                AppDialog.hideDialog(context);
                AppDialog.showErrorDialog(context: context, message: state.error);
              }
            },
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
                          onTap: () {
                            Navigator.of(context).pop();
                          },
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
      ),
    );
  }

  void validation() {
    name = nameTextController.text;
    email = emailTextController.text;
    password = passwordTextController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      AppDialog.showToast(context: context, message: "Field's can't be empty.");
    } else {
      AppDialog.showLoading(context: context);
      _bloc.add(
        UserRegisterEvent(
          name: name,
          email: email,
          password: password,
        ),
      );
    }
  }
}
