import 'package:flutter/material.dart';

import '../components/AppBar.dart';
import '../utils/constants/colors.dart';

class VotePage extends StatelessWidget {
  final String election;

  const VotePage({Key? key, required this.election}) : super(key: key);

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
