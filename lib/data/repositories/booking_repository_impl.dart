import 'package:doctor_booking/core/exceptions/repository_exception.dart';
import 'package:doctor_booking/data/sources/booking_local_source.dart';
import 'package:doctor_booking/data/tables/bookings/booking_table.dart';
import 'package:doctor_booking/data/tables/bookings/booking_table_extensions.dart';

import 'package:doctor_booking/domain/entities/booking_entity.dart';
import 'package:doctor_booking/domain/repositories/booking_repository.dart';
import 'package:uuid/uuid.dart';

class BookingRepositoryImpl implements BookingRepository {
  BookingRepositoryImpl(this.localSource);

  final BookingLocalSource localSource;
  final _uuid = const Uuid();

  @override
  List<Booking> getAllBookings() {
    try {
      return localSource.getAll().map((t) => t.toDomain()).toList();
    } catch (e) {
      throw RepositoryException('Failed to fetch bookings', e);
    }
  }

  @override
  List<Booking> getBookingsByDoctor(String doctorId) {
    try {
      return localSource
          .getByDoctor(doctorId)
          .map(
            (t) => t.toDomain(),
          )
          .toList();
    } catch (e) {
      throw RepositoryException('Failed to fetch bookings for doctor', e);
    }
  }

  @override
  Future<Booking?> createBooking({
    required String doctorId,
    required String patientName,
    required DateTime date,
    required String slotStart,
    required String slotEnd,
    required String reason,
  }) async {
    try {
      final bookings = _getBookingsForDoctorAndDate(doctorId, date, slotStart: slotStart, slotEnd: slotEnd);

      final isTaken = bookings.isNotEmpty;

      if (isTaken) {
        throw Exception('This slot is already booked.');
      }

      final id = _uuid.v4();

      final table = BookingTable(
        id: id,
        doctorId: doctorId,
        patientName: patientName,
        slotStart: slotStart,
        slotEnd: slotEnd,
        date: date,
        reason: reason,
      );

      await localSource.save(table);
      return table.toDomain();
    } catch (e) {
      throw RepositoryException('Failed to create booking', e);
    }
  }

  @override
  Future<Booking?> updateBookingStatus(String id, BookingStatus status) async {
    try {
      final existing = localSource.getById(id);
      if (existing == null) {
        throw RepositoryException('Booking not found', Exception());
      }

      final updated = BookingTable(
        id: existing.id,
        doctorId: existing.doctorId,
        patientName: existing.patientName,
        date: existing.date,
        slotStart: existing.slotStart,
        slotEnd: existing.slotEnd,
        reason: existing.reason,
        status: status.toTable(),
      );

      await localSource.save(updated);
      return updated.toDomain();
    } catch (e) {
      throw RepositoryException('Failed to update booking status', e);
    }
  }

  @override
  Booking? getBookingById(String id) {
    try {
      final table = localSource.getById(id);

      if (table == null) return null;

      return table.toDomain();
    } catch (e) {
      throw RepositoryException('Failed to get booking by id', e);
    }
  }

  List<Booking> _getBookingsForDoctorAndDate(
    String doctorId,
    DateTime date, {
    String? slotStart,
    String? slotEnd,
  }) {
    return getAllBookings()
        .where(
          (b) =>
              b.doctorId == doctorId &&
              b.date.year == date.year &&
              b.date.month == date.month &&
              b.date.day == date.day &&
              (slotStart == null || b.slotStart == slotStart) &&
              (slotEnd == null || b.slotEnd == slotEnd) &&
              b.status != BookingStatus.rejected,
        )
        .toList();
  }
}
