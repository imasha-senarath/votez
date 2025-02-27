import 'package:flutter/material.dart';

import '../components/AppBar.dart';
import '../components/app_dialog.dart';
import '../components/poll_item.dart';
import '../models/poll.dart';
import '../services/firebase_service.dart';
import '../utils/DateUtils.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';

class VotePage extends StatefulWidget {
  final Poll poll;

  const VotePage({
    super.key,
    required this.poll,
  });

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  final FirebaseService _firebase = FirebaseService();
  late String? userId = FirebaseService.getUserId();

  bool _isVoted = false;

  List<Map<String, dynamic>> _pollsData = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchPollsData() async {
    try {
      List<Map<String, dynamic>> fetchedData = await _firebase.getFilteredData('Votes', "poll", widget.poll.id);
      setState(() {
        _pollsData = fetchedData;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _vote(int option) async {
    Map<String, dynamic> voteData = {
      "poll": widget.poll.id,
      "option": option,
      "user": userId,
      "time": DateUtil.getCurrentTime(),
      "date": DateUtil.getCurrentDate(),
    };

    try {
      await _firebase.addData("Votes", voteData, null);
      AppDialog.showToast(context: context, message: "Voted");
      setState(() {
        _isVoted = true;
      });
    } catch (e) {
      AppDialog.showErrorDialog(context: context, message: "Failed to add data: $e");
    }
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
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.poll.question,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ListView.builder(
              itemCount: widget.poll.options.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final option = widget.poll.options[index];
                return Padding(
                    padding: EdgeInsets.only(bottom: index == widget.poll.options.length - 1 ? 0 : 5.0),
                    child: GestureDetector(
                      onTap: () {
                        _vote(index);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.grey, // Background color
                          borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                        ),
                        child: PollItem(
                          option: option,
                          isVoted: _isVoted,
                        ),
                      ),
                    ));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Spacer(),
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
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
