import 'package:flutter/material.dart';

import '../../models/poll.dart';
import '../../models/profile.dart';
import '../constants/app_assets.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class PollCard extends StatelessWidget {
  final Poll poll;
  final Profile profile;
  final int voteCount;

  const PollCard({
    super.key,
    required this.poll,
    required this.profile,
    required this.voteCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Image(
                  image: AssetImage(AppAssets.user),
                  width: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  profile.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${poll.time} • ${poll.date}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          //color: Colors.black54,
                          ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              poll.question,
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
                ),
                const SizedBox(width: 5),
                Text(
                  "$voteCount Votes",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.check_circle_outline,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  "${poll.options.length} Options",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
