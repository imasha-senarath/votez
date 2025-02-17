import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';

class PollCard extends StatelessWidget {
  const PollCard({
    super.key,
    required this.polls,
    required this.index,
  });

  final List<Map<String, dynamic>> polls;
  final int index;

  @override
  Widget build(BuildContext context) {
    final poll = polls[index];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              poll['question'],
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
                  Icons.check_circle_outline,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
                SizedBox(width: 5),
                Text(
                  "3 Options",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.thumb_up_alt_outlined,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
                SizedBox(width: 5),
                Text(
                  "5 Voters",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("${poll['time']} • ${poll['date']}")
              ],
            )
          ],
        ),
      ),
    );
  }
}