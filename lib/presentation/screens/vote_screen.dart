import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/presentation/blocs/vote/vote_state.dart';

import '../../core/di/dependency_injection.dart';
import '../../core/widgets/app_dialog.dart';
import '../../core/widgets/appbar.dart';
import '../../core/widgets/poll_item.dart';
import '../../models/poll.dart';
import '../../models/profile.dart';
import '../../models/vote.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../blocs/vote/vote_bloc.dart';
import '../blocs/vote/vote_event.dart';

class VotePage extends StatefulWidget {
  final Poll poll;
  final Profile profile;

  const VotePage({
    super.key,
    required this.poll,
    required this.profile,
  });

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  late final VoteBloc _bloc = injection<VoteBloc>();

  late String? userId;

  List<Vote> _votes = [];
  int _totalVotes = 0;
  int _votedOption = -1;

  Map<int, int> _votePercentages = {0: 0};

  bool _isFetchingData = true;

  @override
  void initState() {
    super.initState();
    _bloc.add(GeUserIdEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.primaryBackground,
      appBar: const CustomAppBar(
        title: "Vote",
        enableBackButton: true,
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<VoteBloc, VoteState>(
          listener: (context, state) {
            if (state is GetUserIdSuccessState) {
              userId = state.userId;
              _bloc.add(GetPollVotesEvent(pollId: widget.poll.id));
            } else if (state is GetUserIdFailedState) {
              AppDialog.showErrorDialog(context: context, message: state.error);
            }
            if (state is GetPollVotesSuccessState) {
              setState(() {
                _votes = state.votes;
                analysePoll();
              });
            } else if (state is GetPollVotesFailedState) {
              AppDialog.showErrorDialog(context: context, message: state.error);
            }
            if (state is UserVoteSuccessState) {
              AppDialog.showToast(context: context, message: "Voted");
              setState(() {
                //_votedOption = option;
                _bloc.add(GetPollVotesEvent(pollId: widget.poll.id));
              });
            } else if (state is UserVoteFailedState) {
              AppDialog.showErrorDialog(context: context, message: state.error);
            }
          },
          child: _isFetchingData
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(AppSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Image(
                            image: AssetImage(AppAssets.user),
                            width: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.profile.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.poll.question,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                                  if( _votedOption == -1) {
                                    _bloc.add(
                                      UserVoteEvent(
                                        poll: widget.poll.id,
                                        option: index,
                                        user: userId!,
                                      ),
                                    );
                                  }
                                },
                                child: PollItem(
                                  option: option,
                                  votedOption: _votedOption,
                                  index: index,
                                  votePercentages: _votePercentages,
                                ),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 20
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "$_totalVotes Voters",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const Spacer(),
                          Text(
                            "${widget.poll.time} • ${widget.poll.date}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void analysePoll() {
    if (_votes.isNotEmpty) {
      _totalVotes = _votes.length;
      _votedOption = getVotedOption(widget.poll.id, userId!);
      _votePercentages = getVotePercentages();
    }

    setState(() {
      _isFetchingData = false;
    });
  }

  int getVotedOption(String pollId, String userId) {
    final vote = _votes.firstWhere(
          (vote) => vote.poll == pollId && vote.user == userId,
      orElse: () => Vote(id: '', poll: '', option: -1, user: '', date: '', time: ''),
    );

    return vote.option;
  }

  Map<int, int> getVotePercentages() {
    int totalVotes = _votes.length;

    Map<int, int> optionCounts = {};
    for (Vote vote in _votes) {
      optionCounts[vote.option] = (optionCounts[vote.option] ?? 0) + 1;
    }

    Map<int, int> votePercentages = {};
    optionCounts.forEach((option, count) {
      votePercentages[option] = ((count / totalVotes) * 100).round();
    });

    return votePercentages;
  }
}
