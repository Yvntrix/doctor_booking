import 'package:doctor_booking/core/exceptions/local_source_exception.dart';
import 'package:doctor_booking/data/tables/bookings/booking_table.dart';

import 'package:hive_ce/hive.dart';

class BookingLocalSource {
  BookingLocalSource(this._box);

  final Box<BookingTable> _box;

  List<BookingTable> getAll() {
    try {
      return _box.values.toList();
    } catch (e) {
      throw LocalSourceException('Failed to fetch all bookings', e);
    }
  }

  List<BookingTable> getByDoctor(String doctorId) {
    try {
      return _box.values.where((b) => b.doctorId == doctorId).toList();
    } catch (e) {
      throw LocalSourceException('Failed to fetch bookings by doctor', e);
    }
  }

  Future<void> save(BookingTable booking) async {
    try {
      await _box.put(booking.id, booking);
    } catch (e) {
      throw LocalSourceException('Failed to save booking', e);
    }
  }

  BookingTable? getById(String id) {
    try {
      return _box.get(id);
    } catch (e) {
      throw LocalSourceException('Failed to get booking by id', e);
    }
  }
}
