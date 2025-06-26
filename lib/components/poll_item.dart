import 'dart:ffi';

import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/sizes.dart';

class PollItem extends StatelessWidget {
  const PollItem({
    super.key,
    required this.option,
    required this.votedOption,
    required this.index,
    required this.votePercentages,
  });

  final String option;
  final int votedOption;
  final int index;
  final Map<int, int> votePercentages;

  @override
  Widget build(BuildContext context) {

    final bool isVoted = votedOption != -1;
    final bool isSelected = votedOption != -1 && index == votedOption;
    final int percentage = votePercentages[index] ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : AppColors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Text(
              option,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isSelected ? Colors.white : null,
                  ),
            ),
            const Spacer(),
            if (isVoted)
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isSelected ? Colors.white : null,
                    ),
              )
          ],
        ),
      ),
    );
  }
}
