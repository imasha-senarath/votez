import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:votez/screens/vote_screen.dart';
import 'package:votez/screens/create_poll_screen.dart';
import 'package:votez/utils/constants/colors.dart';

import '../components/app_dialog.dart';
import '../components/poll_card.dart';
import '../services/firebase_service.dart';
import '../utils/constants/app_assets.dart';
import '../utils/constants/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _firebase = FirebaseService();
  late String userId;

  List<String> _categories = ["Food", "Technology", "Fashion"];
  bool _isLoading = true;

  List<Map<String, dynamic>> _polls = [];
  bool _isPollsLoading = true;

  @override
  void initState() {
    super.initState();
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
                  const Text(
                    "Top Categories",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Trending",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
                  const SizedBox(height: 15),
                  _isPollsLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: _polls.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.only(bottom: index == _polls.length - 1 ? 0 : 5.0),
                                child: PollCard(polls: _polls, index: index));
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
}
