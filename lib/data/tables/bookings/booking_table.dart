import 'package:hive_ce/hive.dart';

part 'booking_table.g.dart';

@HiveType(typeId: 3)
enum BookingTableStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  approved,
  @HiveField(2)
  rejected,
}

@HiveType(typeId: 4)
class BookingTable extends HiveObject {
  BookingTable({
    required this.id,
    required this.doctorId,
    required this.patientName,
    required this.date,
    required this.slotStart,
    required this.slotEnd,
    required this.reason,
    this.status = BookingTableStatus.pending,
  });
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String doctorId;

  @HiveField(2)
  final String patientName;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String slotStart;

  @HiveField(5)
  final String slotEnd;

  @HiveField(6)
  final String reason;

  @HiveField(7)
  final BookingTableStatus status;
}
