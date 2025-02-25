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
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Icon(
                  Icons.thumb_up_alt_outlined,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(width: 5),
                Text(
                  "5 Votes",
                    style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.check_circle_outline,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(width: 5),
                Text(
                  "3 Options",
                    style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: 15,
                ),

              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${poll['time']} • ${poll['date']}",
                    style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
