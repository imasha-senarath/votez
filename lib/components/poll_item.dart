import 'dart:ffi';

import 'package:flutter/material.dart';

class PollItem extends StatelessWidget {
  const PollItem({
    super.key,
    required this.option,
    required this.isVoted,
  });

  final String option;
  final bool isVoted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Text(
              option,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            if(isVoted)
            Text(
              "70%",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
