import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:votez/components/appbar.dart';

import '../utils/constants/app_assets.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      /*appBar: const CustomAppBar(
        title: 'Setting',
        enableBackButton: false,
      ),*/
      body: SafeArea(
        child: Padding(
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
                        children: const [
                          Text(
                            "Imasha Senarath",
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            "970654765V",
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
              ),
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
                        title: 'Logout',
                        icon: Icons.notifications,
                      ),
                    ],
                  ),
                ),
              ),
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

  const SettingCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
