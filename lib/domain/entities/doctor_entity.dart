import 'package:intl/intl.dart';

class Doctor {
  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.availability,
  });

  final String id;
  final String name;
  final String specialty;
  final List<DoctorAvailability> availability;
}

class DoctorAvailability {
  DoctorAvailability({
    required this.day,
    required this.slots,
  });

  final String day;
  final List<DoctorSlot> slots;
}

class DoctorSlot {
  DoctorSlot({
    required this.start,
    required this.end,
  });

  final String start;
  final String end;

  String get startTime => _formatTime(start);

  String get endTime => _formatTime(end);

  static String _formatTime(String time) {
    final dateTime = DateFormat.Hm().parse(time);
    return DateFormat.jm().format(dateTime);
  }
}
