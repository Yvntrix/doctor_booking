import 'package:doctor_booking/data/sources/doctor_seed_source.dart';
import 'package:doctor_booking/data/tables/bookings/booking_table.dart';
import 'package:doctor_booking/data/tables/doctors/doctor_table.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveService {
  static const String _doctorKey = 'doctors';
  static const String _bookingKey = 'bookings';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter(DoctorTableAdapter())
      ..registerAdapter(DoctorAvailabilityTableAdapter())
      ..registerAdapter(DoctorSlotTableAdapter())
      ..registerAdapter(BookingTableStatusAdapter())
      ..registerAdapter(BookingTableAdapter());

    await Hive.openBox<DoctorTable>(_doctorKey);
    await Hive.openBox<BookingTable>(_bookingKey);

    await DoctorSeedSource(doctorBox).seedIfEmpty();
  }

  static Box<DoctorTable> get doctorBox => Hive.box<DoctorTable>(_doctorKey);
  static Box<BookingTable> get bookingBox => Hive.box<BookingTable>(
    _bookingKey,
  );
}
