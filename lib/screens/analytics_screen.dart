import 'package:flutter/material.dart';
import 'package:votez/components/AppBar.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Analytics',
        enableBackButton: false,
      ),
    );
  }
}
