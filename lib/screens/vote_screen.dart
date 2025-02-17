import 'package:flutter/material.dart';

import '../components/AppBar.dart';
import '../models/poll.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';

class VotePage extends StatefulWidget {
  final Map<String, dynamic> poll;

  const VotePage({Key? key, required this.poll}) : super(key: key);

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  late List<String> _options;
  bool _isOptionsLoading = true;

  @override
  void initState() {
    super.initState();
    _analyzePoll();
  }

  void _analyzePoll() {
    _options = widget.poll['options'].split('|');
    _isOptionsLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: const CustomAppBar(
        title: "Vote",
        enableBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.poll['question'],
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
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
            const SizedBox(height: 20),
            _isOptionsLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _options.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final option = _options[index];
                      return Padding(
                          padding: EdgeInsets.only(bottom: index == _options.length - 1 ? 0 : 5.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              option,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ));
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
