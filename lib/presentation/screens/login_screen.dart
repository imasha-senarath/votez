import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/presentation/blocs/login/login_event.dart';
import 'package:votez/presentation/blocs/login/login_state.dart';
import 'package:votez/core/widgets/app_button.dart';
import 'package:votez/core/widgets/text_field.dart';
import 'package:votez/core/constants/app_assets.dart';

import '../../data/datasources/firebase_service.dart';
import '../../data/repositories/repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../blocs/login/login_bloc.dart';
import '../../core/widgets/app_dialog.dart';
import '../../core/constants/sizes.dart';

class LoginScreen extends StatefulWidget {
  final Function() onTap;

  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseService _firebase = FirebaseService();
  late final LoginBloc _bloc;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = LoginBloc(
      loginUseCase: LoginUseCase(
        RepositoryImpl(
          firebase: _firebase,
        ),
      ),
    );
  }

  void validation() {
    var email = emailTextController.text;
    var password = passwordTextController.text;

    if (email.isEmpty || password.isEmpty) {
      AppDialog.showToast(context: context, message: "Field's can't be empty.");
    } else {
      AppDialog.showLoading(context: context);
      _bloc.add(
        LoginPressed(
          email: email,
          password: password,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => _bloc,
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                AppDialog.hideDialog(context);
              } else if (state is LoginFailure) {
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
        ),
      ),
    );
  }
}
