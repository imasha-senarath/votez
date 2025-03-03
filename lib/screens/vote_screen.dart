import 'package:flutter/material.dart';

import '../components/AppBar.dart';
import '../components/app_dialog.dart';
import '../components/poll_item.dart';
import '../models/poll.dart';
import '../models/vote.dart';
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

  List<Vote> _votes = [];
  int _voteCount = 0;
  int _votedOption = -1;

  bool _isFetchingData = true;

  @override
  void initState() {
    super.initState();
    _fetchVotes();
  }

  Future<void> _fetchVotes() async {
    try {
      List<Map<String, dynamic>> fetchedData = await _firebase.getData('Votes');
      setState(() {
        _votes = fetchedData.map((data) => Vote.fromMap(data)).toList();
        analysePoll();
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isFetchingData = false;
      });
    }
  }

  void analysePoll() {
    _voteCount = getVoteCount(widget.poll.id);
    _votedOption = getVotedOption(widget.poll.id, userId!);
    AppDialog.showToast(context: context, message: _votedOption.toString());
    setState(() {
      _isFetchingData = false;
    });
  }

  int getVoteCount(String pollId) {
    return _votes.where((vote) => vote.poll == pollId).length;
  }

  int getVotedOption(String pollId, String userId) {
    final vote = _votes.firstWhere(
      (vote) => vote.poll == pollId && vote.user == userId,
      orElse: () => Vote(id: '', poll: '', option: -1, user: '', date: '', time: ''),
    );

    return vote.option;
  }

  bool hasUserVoted(String pollId, String userId) {
    return _votes.any((vote) => vote.poll == pollId && vote.user == userId);
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
        _votedOption = option;
        _fetchVotes();
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
      body: _isFetchingData
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                              _votedOption == -1 ? _vote(index) : null;
                            },
                            child: PollItem(
                              option: option,
                              votedOption: _votedOption,
                              index: index,
                            ),
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      const Icon(
                        Icons.thumb_up_alt_outlined,
                        size: 20,
                        color: AppColors.textPrimary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "$_voteCount Voters",
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(
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
