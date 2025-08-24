import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:votez/core/constants/colors.dart';
import 'package:votez/utils/theme/theme.dart';

import '../core/di/dependency_injection.dart' as di;
import 'core/navigation/app_router..dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBoUp8Q_i_jBX_bCdQTwVh6KBIz0Abg6DQ",
      appId: "com.imasha.votez",
      messagingSenderId: "",
      projectId: "votez-73e1e",
    ),
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryBackground, // Status bar color
        statusBarIconBrightness: Brightness.dark, // Icons color
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.kSplashScreen,
      onGenerateRoute: AppRouter.generateRoute,
      themeMode: ThemeMode.dark,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      //home: const SplashScreen(),
    );
  }
}
