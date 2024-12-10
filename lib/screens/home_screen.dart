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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primary, // Background color
                        borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
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
                              width: 45,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.black, // Background color
                    borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Active Election",
                              style: TextStyle(
                                color: AppColors.textWhite,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.circle,
                              size: 15,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Presidential Election',
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.access_alarm,
                              size: 20,
                              color: AppColors.textWhite,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Ends In: 1h 30min",
                              style: TextStyle(
                                color: AppColors.textWhite,
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.verified,
                              size: 20,
                              color: AppColors.textWhite,
                            ),
                            SizedBox(width: 5),
                            Text("5 Candidates",
                                style: TextStyle(
                                  color: AppColors.textWhite,
                                )),
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
                  "Upcoming Elections",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                ListView.builder(
                  itemCount: elections.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(bottom: index == elections.length - 1 ? 0 : 5.0),
                        child: ElectionCard(elections: elections, index: index));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Announcements",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              elections[index],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: const [
                Icon(
                  Icons.date_range,
                  size: 20,
                ),
                SizedBox(width: 5),
                Text("10 Dec 2025"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
