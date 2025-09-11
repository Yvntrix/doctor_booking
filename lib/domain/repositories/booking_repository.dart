import 'package:doctor_booking/domain/entities/booking_entity.dart';

abstract class BookingRepository {
  List<Booking> getAllBookings();
  List<Booking> getBookingsByDoctor(String doctorId);

  Future<Booking?> createBooking({
    required String doctorId,
    required String patientName,
    required DateTime date,
    required String reason,
  });

  Future<Booking?> updateBookingStatus(String id, BookingStatus status);
}
