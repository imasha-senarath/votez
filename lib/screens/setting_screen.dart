import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:votez/components/appbar.dart';
import 'package:votez/screens/login_screen.dart';

import '../components/app_dialog.dart';
import '../services/auth.dart';
import '../services/firebase_service.dart';
import '../utils/constants/app_assets.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final FirebaseService firebase = FirebaseService();
  late String userId;
  bool isLoading = true;
  late Map<String, dynamic>? profileData;

  @override
  void initState() {
    super.initState();
    userId = FirebaseService.getUserId()!;
    _fetchProfile(userId);
  }

  Future<void> _fetchProfile(String id) async {
    try {
      Map<String, dynamic>? fetchedData = await firebase.getSingleData('Users', id);
      setState(() {
        isLoading = false;
        profileData = fetchedData;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        print('Error: $e');
      });
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(onTap: () {})), // Replace with your LoginPage widget
      );
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white, // Background color
                        borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            const Image(
                              image: AssetImage(AppAssets.user),
                              width: 60,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileData != null && profileData!["name"] != null ? profileData!["name"] : "--",
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  profileData != null && profileData!["email"] != null ? profileData!["email"] : "--",
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ), // Profile
                    const SizedBox(height: 15),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white, // Background color
                        borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          children: const [
                            SettingCard(
                              title: 'Notifications',
                              icon: Icons.notifications,
                            ),
                            SizedBox(height: 30),
                            SettingCard(
                              title: 'Theme',
                              icon: Icons.color_lens,
                            ),
                          ],
                        ),
                      ),
                    ), // Settings
                    const SizedBox(height: 15),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white, // Background color
                        borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          children:  [
                            SettingCard(
                              title: 'Logout',
                              icon: Icons.notifications,
                              onTap: () {
                                AppDialog.showConfirmDialog(context: context, title: "Logout", message: "Are you sure you want to log out?", onConfirm: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const AuthPage()),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ), // Logout
                  ],
                ),
              ),
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;

  const SettingCard({
    super.key,
    required this.title,
    required this.icon, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 26,
            color: Colors.grey.shade400,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}
