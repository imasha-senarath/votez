import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/models/vote.dart';
import 'package:votez/presentation/blocs/home/home_bloc.dart';
import 'package:votez/presentation/blocs/home/home_event.dart';
import 'package:votez/presentation/blocs/home/home_state.dart';
import 'package:votez/presentation/screens/vote_screen.dart';
import 'package:votez/presentation/screens/create_poll_screen.dart';
import 'package:votez/core/constants/colors.dart';

import '../../core/di/dependency_injection.dart';
import '../../core/navigation/app_router..dart';
import '../../core/widgets/app_dialog.dart';
import '../../core/widgets/poll_card.dart';
import '../../models/poll.dart';
import '../../models/profile.dart';
import '../../data/datasources/firebase_service.dart';
import '../../utils/date_utils.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _bloc = injection<HomeBloc>();

  final FirebaseService _firebase = FirebaseService();
  late String userId;

  final List<String> _categories = ["Food", "Technology", "Fashion", "Science", "Sports", "Life"];

  late Profile _profile;
  bool _isProfileLoading = true;

  List<Profile> _profiles = [];
  List<Poll> _polls = [];
  List<Vote> _votes = [];

  bool _isFetchingData = true;

  @override
  void initState() {
    super.initState();
    userId = FirebaseService.getUserId()!;

    _bloc.add(GetProfilesEvent());
  }

  Future<void> _fetchVotes() async {
    try {
      List<Map<String, dynamic>> fetchedData = await _firebase.getData('Votes');
      setState(() {
        _votes = fetchedData.map((data) => Vote.fromMap(data)).toList();
        _isFetchingData = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isFetchingData = false;
      });
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRouter.kCreatePollScreen);
        },
        child: const Icon(Icons.add), // Icon for the FAB
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => _bloc,
          child: BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is GetProfilesSuccessState) {
                _profiles = state.profiles;
                _profile = getProfile(userId)!;
                _isProfileLoading = false;
                _bloc.add(GetPollsEvent());
              } else if (state is GetProfilesFailedState) {
                AppDialog.showErrorDialog(context: context, message: state.error);
              }
              if (state is GetPollsSuccessState) {
                _polls = state.polls;
                _fetchVotes();
              } else if (state is GetPollsFailedState) {
                AppDialog.showErrorDialog(context: context, message: state.error);
              }
            },
            child: _isProfileLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 18), //
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary, // Background color
                                    borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Hey ${_profile.name.split(' ').first},",
                                              style: const TextStyle(
                                                color: AppColors.textWhite,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Text(
                                              DateUtil.getGreeting(),
                                              style: const TextStyle(
                                                color: AppColors.textWhite,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        const Image(
                                          image: AssetImage(AppAssets.user),
                                          width: 45,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Top Categories",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 38,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: _categories.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: index == _categories.length - 1 ? 0 : 5.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(
                                            // Border settings
                                            color: Colors.grey, // Border color
                                            width: 1.0, // Border width
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                          child: Center(child: Text(_categories[index])),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Recent Polls",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            _isFetchingData
                                ? const Center(child: CircularProgressIndicator())
                                : ListView.builder(
                                    itemCount: _polls.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final poll = _polls[index];
                                      final pollProfile = getProfile(poll.user)!;
                                      int voteCount = getVoteCount()[poll.id] ?? 0;
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: index == _polls.length - 1 ? 0 : 5.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => VotePage(
                                                  poll: poll,
                                                  profile: pollProfile,
                                                ),
                                              ),
                                            );
                                          },
                                          child: PollCard(
                                            poll: poll,
                                            profile: pollProfile,
                                            voteCount: voteCount,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Profile? getProfile(String id) {
    try {
      return _profiles.firstWhere((profile) => profile.id == id);
    } catch (e) {
      return null;
    }
  }

  Map<String, int> getVoteCount() {
    Map<String, int> pollVoteCounts = {};

    for (Poll poll in _polls) {
      int voteCount = _votes.where((vote) => vote.poll == poll.id).length;
      pollVoteCounts[poll.id] = voteCount;
    }

    return pollVoteCounts;
  }
}
