import '../utils/DateUtils.dart';

class Poll {
  final String question;
  final List<String> options;
  final String user;
  final String date;
  final String time;

  Poll({
    required this.question,
    required this.options,
    required this.user,
    String? date,
    String? time,
  })  : date = date ?? DateUtil.getCurrentDate(),
        time = time ?? DateUtil.getCurrentTime();

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options.join('|'),
      'user': user,
      'date': date,
      'time': time,
    };
  }
}
