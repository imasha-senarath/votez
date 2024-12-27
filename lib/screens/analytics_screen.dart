import 'package:flutter/material.dart';
import 'package:votez/components/appbar.dart';

import '../utils/constants/colors.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: 'Analytics',
        enableBackButton: false,
      ),
    );
  }
}
