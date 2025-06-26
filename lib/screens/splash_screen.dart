import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:votez/screens/home_screen.dart';

import '../data/datasources/auth.dart';
import '../core/constants/colors.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String appVersion = "";

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthPage(),
          ));
    });

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appVersion = packageInfo.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
    );
  }
}
