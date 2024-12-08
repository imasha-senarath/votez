import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:votez/screens/splash_screen.dart';
import 'package:votez/utils/constants/colors.dart';
import 'package:votez/utils/theme/theme.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.white, // Status bar color
        statusBarIconBrightness: Brightness.dark, // Icons color
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(),
      darkTheme: ThemeData(),
      home: const SplashScreen(),
    );
  }
}
