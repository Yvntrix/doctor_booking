import 'package:doctor_booking/data/tables/bookings/booking_table.dart';
import 'package:doctor_booking/domain/entities/booking_entity.dart';

extension BookingTableX on BookingTable {
  Booking toDomain() => Booking(
    id: id,
    doctorId: doctorId,
    patientName: patientName,
    date: date,
    reason: reason,
    status: status.toDomain(),
  );
}

extension BookingStatusMapper on BookingStatus {
  BookingTableStatus toTable() => switch (this) {
    BookingStatus.pending => BookingTableStatus.pending,
    BookingStatus.approved => BookingTableStatus.approved,
    BookingStatus.rejected => BookingTableStatus.rejected,
  };
}

extension BookingTableStatusMapper on BookingTableStatus {
  BookingStatus toDomain() => switch (this) {
    BookingTableStatus.pending => BookingStatus.pending,
    BookingTableStatus.approved => BookingStatus.approved,
    BookingTableStatus.rejected => BookingStatus.rejected,
  };
}
