import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:votez/screens/candidates_screen.dart';
import 'package:votez/screens/create_poll_screen.dart';
import 'package:votez/utils/constants/colors.dart';

import '../components/app_dialog.dart';
import '../services/firebase_service.dart';
import '../utils/constants/app_assets.dart';
import '../utils/constants/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String currentUserId;

  final FirebaseService _firebase = FirebaseService();

  List<Map<String, dynamic>> _announcements = [];
  bool _isLoading = true;

  List<Map<String, dynamic>> _polls = [];
  bool _isPollsLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
    _fetchPolls();
  }

  Future<void> _fetchPolls() async {
    try {
      List<Map<String, dynamic>> fetchedData = await _firebase.getData('Polls');
      setState(() {
        _polls = fetchedData;
        _isPollsLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isPollsLoading = false;
      });
    }
  }

  Future<void> _fetchAnnouncements() async {
    try {
      List<Map<String, dynamic>> fetchedData = await _firebase.getData('Announcements');
      setState(() {
        _announcements = fetchedData;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePollScreen(),
            ),
          );
        },
        child: const Icon(Icons.add), // Icon for the FAB
      ),
      body: SafeArea(
        child: Padding(
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
                          padding: EdgeInsets.all(18),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Hey Imasha,",
                                    style: TextStyle(
                                      color: AppColors.textWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    "Good Evening",
                                    style: TextStyle(
                                      color: AppColors.textWhite,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
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
                  GestureDetector(
                    onTap: () {
                      addData(
                        'Elections',
                        {
                          'title': 'Parliamentary Elections',
                          'date': '10 Dec 2025',
                          'startTime': '08:00 AM',
                          'endTime': '04:00 PM'
                        },
                      );

                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CandidatesPage(election: 'Presidential Election'),
                        ),
                      );*/
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white, // Background color
                        borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Active Election",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.circle,
                                  size: 15,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            const Text(
                              'Presidential Election',
                              style: TextStyle(
                                color: AppColors.textPrimary,
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
                                  Icons.access_alarm,
                                  size: 20,
                                  color: AppColors.textPrimary,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Ends In: 1h 30min",
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.verified,
                                  size: 20,
                                  color: AppColors.textPrimary,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "5 Candidates",
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Announcements",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: _announcements.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final announcements = _announcements[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: index == _announcements.length - 1 ? 0 : 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(18),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          announcements['content'],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Image(
                                        image: AssetImage(AppAssets.appLogo),
                                        width: 60,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Upcoming Elections",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _isPollsLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: _polls.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final polls = _polls[index];
                            return Padding(
                                padding: EdgeInsets.only(bottom: index == _polls.length - 1 ? 0 : 5.0),
                                child: ElectionCard(polls: _polls, index: index));
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection(collection).add(data);
      AppDialog.showToast(context: context, message: "success");
    } catch (e) {
      AppDialog.showErrorDialog(context: context, message: e.toString());
      print("Error adding document: $e");
      rethrow;
    }
  }
}

class ElectionCard extends StatelessWidget {
  const ElectionCard({
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
                  Icons.date_range,
                  size: 20,
                ),
                SizedBox(width: 5),
                Text("10 Dec 2025"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
