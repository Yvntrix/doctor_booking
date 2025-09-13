import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get weekdayName {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[weekday - 1];
  }

  String get formattedDate {
    return DateFormat('EEEE, MMM d, y').format(this);
  }
}
