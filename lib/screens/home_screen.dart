import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:votez/screens/candidates_screen.dart';
import 'package:votez/utils/constants/colors.dart';

import '../components/app_dialog.dart';
import '../utils/constants/app_assets.dart';
import '../utils/constants/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List elections = ['Presidential Elections', 'Parliamentary Elections', 'General Elections'];
  List announcements = ['1', '2'];

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
  }

  Future<void> _fetchAnnouncements() async {
    /*try {
      List<Map<String, dynamic>> fetchedData = await _firestoreService.fetchCollection('your_collection_name');
      setState(() {
        _items = fetchedData;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }*/
  }


  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
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
                                    "Good Morning",
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
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      addData(
                        'Announcements',
                        {
                          'content':
                              'Scelerisque ut justo commodo quis imperdiet non, lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam placerat urna sed erat rhoncus volutpat. Aenean nulla dolor.',
                          'status': 'inactive'
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
                  ListView.builder(
                    itemCount: announcements.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: index == announcements.length - 1 ? 0 : 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(18),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam placerat urna sed erat rhoncus volutpat. Aenean nulla dolor, commodo quis imperdiet non, scelerisque ut justo.',
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image(
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
                  ListView.builder(
                    itemCount: elections.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.only(bottom: index == elections.length - 1 ? 0 : 5.0),
                          child: ElectionCard(elections: elections, index: index));
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
    required this.elections,
    required this.index,
  });

  final List elections;
  final int index;

  @override
  Widget build(BuildContext context) {
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
              elections[index],
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
