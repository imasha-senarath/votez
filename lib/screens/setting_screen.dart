import 'package:flutter/material.dart';
import 'package:votez/components/AppBar.dart';

import '../utils/constants/app_assets.dart';
import '../utils/constants/colors.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Setting',
        enableBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Row(

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
            const SizedBox(height: 30),
            const SettingCard(
              title: 'Notifications',
              icon: Icons.notifications,
            ),
            const SettingCard(
              title: 'Theme',
              icon: Icons.color_lens,
            ),
          ],
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
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.grey.shade400,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          const Spacer(),
          const Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}