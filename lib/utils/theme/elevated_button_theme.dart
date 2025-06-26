import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._(); //To avoid creating instances

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.light,
      backgroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.darkGrey,
      disabledBackgroundColor: AppColors.buttonDisabled,
      side: const BorderSide(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(vertical: AppSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: AppColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.light,
      backgroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.darkGrey,
      disabledBackgroundColor: AppColors.darkerGrey,
      side: const BorderSide(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(vertical: AppSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: AppColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
    ),
  );
}
