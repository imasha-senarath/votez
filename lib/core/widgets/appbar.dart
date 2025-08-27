import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool enableBackButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.enableBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: AppColors.primaryBackground,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          //color: Colors.black,
        ),
      ),
      leading: enableBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
