import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:votez/utils/constants/colors.dart';

import '../utils/constants/app_assets.dart';
import '../utils/constants/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List elections = ['Presidential Elections', 'Parliamentary Elections'];

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.primary, // Background color
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Hey Imasha,",
                                style: TextStyle(
                                  color: AppColors.textWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                "Good Morning",
                                style: TextStyle(
                                  color: AppColors.textWhite,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          const Image(
                            image: AssetImage(AppAssets.user),
                            width: 50,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Ongoing Elections",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                itemCount: elections.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 2),
                    color: AppColors.primary,
                    height: 20,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
