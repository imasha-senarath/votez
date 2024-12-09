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
  List elections = ['Presidential Elections', 'Parliamentary Elections', 'Presidential Elections', 'Parliamentary Elections'];

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
                  borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
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
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: elections.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ElectionCard(elections: elections, index: index);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ElectionCard extends StatelessWidget {
  const ElectionCard({
    super.key,
    required this.elections,
    required this.index,
  });

  final List elections;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              elections[index],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: const [
                Icon(Icons.people),
                SizedBox(width: 5),
                Text("20 Voters"),
                SizedBox(width: 20),
                Icon(Icons.verified),
                SizedBox(width: 5),
                Text("5 Candidates"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
