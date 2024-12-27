import 'package:flutter/material.dart';

import '../components/AppBar.dart';
import '../utils/constants/colors.dart';

class CandidatesPage extends StatelessWidget {
  final String election;

  const CandidatesPage({Key? key, required this.election}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: election,
        enableBackButton: true,
      ),
    );
  }
}
