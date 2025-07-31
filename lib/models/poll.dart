import '../utils/date_utils.dart';

class Poll {
  final String id;
  final String question;
  final List<String> options;
  final String user;
  final String date;
  final String time;

  Poll({
    required this.id,
    required this.question,
    required this.options,
    required this.user,
    String? date,
    String? time,
  })  : date = date ?? DateUtil.getCurrentDate(),
        time = time ?? DateUtil.getCurrentTime();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': options.join('|'),
      'user': user,
      'date': date,
      'time': time,
    };
  }

  factory Poll.fromMap(Map<String, dynamic> map) {
    return Poll(
      id: map['id'] ?? '',
      question: map['question'] ?? '',
      options: (map['options'] as String).split('|'),
      user: map['user'] ?? '',
      date: map['date'] ?? DateUtil.getCurrentDate(),
      time: map['time'] ?? DateUtil.getCurrentTime(),
    );
  }
}
