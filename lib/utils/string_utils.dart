import 'package:intl/intl.dart';

extension StringX on String {
  String get initial => this[0];

  String formatTime() {
    final dateTime = DateFormat.Hm().parse(this);
    return DateFormat.jm().format(dateTime);
  }
}
