import '../utils/DateUtils.dart';

class Vote {
  final String id;
  final String poll;
  final int option;
  final String user;
  final String date;
  final String time;

  Vote({
    required this.id,
    required this.poll,
    required this.option,
    required this.user,
    String? date,
    String? time,
  })  : date = date ?? DateUtil.getCurrentDate(),
        time = time ?? DateUtil.getCurrentTime();

  // Convert object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poll': poll,
      'option': option,
      'user': user,
      'date': date,
      'time': time,
    };
  }

  // Convert map to object
  factory Vote.fromMap(Map<String, dynamic> map) {
    return Vote(
      id: map['id'] ?? '',
      poll: map['poll'] ?? '',
      option: map['option'] ?? '',
      user: map['user'] ?? '',
      date: map['date'] ?? DateUtil.getCurrentDate(),
      time: map['time'] ?? DateUtil.getCurrentTime(),
    );
  }
}
