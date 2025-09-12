import 'package:doctor_booking/utils/string_utils.dart';

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

  String get initials => name.initial;
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

  String get startTime => start.formatTime();

  String get endTime => end.formatTime();
}
