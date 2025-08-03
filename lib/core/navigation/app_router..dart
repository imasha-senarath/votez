import 'package:flutter/material.dart';
import 'package:votez/presentation/screens/create_poll_screen.dart';
import 'package:votez/presentation/screens/main_screen.dart';
import 'package:votez/presentation/screens/register_screen.dart';
import 'package:votez/presentation/screens/splash_screen.dart';

import '../../presentation/screens/login_screen.dart';

class AppRouter {

  static const String kSplashScreen = 'kSplashScreen';
  static const String kLoginScreen = 'kLoginScreen';
  static const String kRegisterScreen = 'kRegisterScreen';
  static const String kMainScreen = 'kMainScreen';
  static const String kHomeScreen = 'kHomeScreen';
  static const String kCreatePollScreen = 'kCreatePollScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kSplashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: const RouteSettings(name: kSplashScreen),
        );

      case kLoginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: const RouteSettings(name: kLoginScreen),
        );

      case kMainScreen:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
          settings: const RouteSettings(name: kMainScreen),
        );

      case kRegisterScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: const RouteSettings(name: kRegisterScreen),
        );

      case kCreatePollScreen:
        return MaterialPageRoute(
          builder: (_) => const CreatePollScreen(),
          settings: const RouteSettings(name: kCreatePollScreen),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
