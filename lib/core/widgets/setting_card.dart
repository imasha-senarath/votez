import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;

  const SettingCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(
              icon,
              size: 26,
              //color: Colors.grey.shade400,
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
      ),
    );
  }
}