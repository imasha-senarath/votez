import 'package:intl/intl.dart';

class DateUtil {

  static String getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('dd MMM yyyy').format(now);
  }

  static String getCurrentTime() {
    final now = DateTime.now();
    return DateFormat('HH:mm').format(now);
  }

  static String getGreeting() {
    int hour = DateTime.now().hour;
    return hour < 12 ? "Good Morning" : "Good Evening";
  }
}
