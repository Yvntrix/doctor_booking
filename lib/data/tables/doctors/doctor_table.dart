import 'package:hive_ce/hive.dart';

part 'doctor_table.g.dart';

@HiveType(typeId: 0)
class DoctorTable extends HiveObject {
  DoctorTable({
    required this.id,
    required this.name,
    required this.specialty,
    required this.availability,
  });

  factory DoctorTable.fromJson(Map<String, dynamic> json) => DoctorTable(
    id: json['id'] as String,
    name: json['name'] as String,
    specialty: json['specialty'] as String,
    availability: (json['availability'] as List)
        .map((a) => DoctorAvailabilityTable.fromJson(a as Map<String, dynamic>))
        .toList(),
  );

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String specialty;

  @HiveField(3)
  final List<DoctorAvailabilityTable> availability;
}

@HiveType(typeId: 1)
class DoctorAvailabilityTable extends HiveObject {
  DoctorAvailabilityTable({
    required this.day,
    required this.slots,
  });

  factory DoctorAvailabilityTable.fromJson(
    Map<String, dynamic> json,
  ) => DoctorAvailabilityTable(
    day: json['day'] as String,
    slots: (json['slots'] as List)
        .map(
          (s) => DoctorSlotTable.fromJson(s as Map<String, dynamic>),
        )
        .toList(),
  );

  @HiveField(0)
  final String day;

  @HiveField(1)
  final List<DoctorSlotTable> slots;
}

@HiveType(typeId: 2)
class DoctorSlotTable extends HiveObject {
  DoctorSlotTable({
    required this.start,
    required this.end,
  });

  factory DoctorSlotTable.fromJson(
    Map<String, dynamic> json,
  ) => DoctorSlotTable(
    start: json['start'] as String,
    end: json['end'] as String,
  );

  @HiveField(0)
  final String start;

  @HiveField(1)
  final String end;
}
