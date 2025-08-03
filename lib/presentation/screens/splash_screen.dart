import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:votez/presentation/blocs/splash/splash_bloc.dart';
import 'package:votez/presentation/blocs/splash/splash_state.dart';

import '../../core/di/dependency_injection.dart';
import '../../core/navigation/app_router..dart';
import '../../core/constants/colors.dart';
import '../blocs/splash/splash_event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashBloc _bloc = injection<SplashBloc>();

  String appVersion = "";

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appVersion = packageInfo.version;
      });
    });

    Timer(const Duration(seconds: 1), () {
      _bloc.add(GeUserIdEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => _bloc,
          child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is GetUserIdSuccessState) {
                Navigator.of(context).pushReplacementNamed(AppRouter.kMainScreen);
              } else if (state is GetUserIdFailedState) {
                Navigator.of(context).pushReplacementNamed(AppRouter.kLoginScreen);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      Text("V$appVersion"),
                      const SizedBox(height: 14),
                      const Text(
                        "From Imasha Senarath",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
