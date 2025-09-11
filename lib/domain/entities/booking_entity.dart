import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Booking {
  Booking({
    required this.id,
    required this.doctorId,
    required this.patientName,
    required this.date,
    required this.reason,
    this.status = BookingStatus.pending,
  });

  final String id;
  final String doctorId;
  final String patientName;
  final DateTime date;
  final String reason;
  final BookingStatus status;

  String get formattedDate => DateFormat.yMMMMd().format(date);

  String get formattedTime => DateFormat.jm().format(date);
}

enum BookingStatus { pending, approved, rejected }

extension BookingStatusX on BookingStatus {
  String label(BuildContext ctx) => switch (this) {
    BookingStatus.pending => 'Pending', //TODO: localize
    BookingStatus.approved => 'Approved', //TODO: localize
    BookingStatus.rejected => 'Rejected', //TODO: localize
  };

  Color get color => switch (this) {
    BookingStatus.pending => Colors.orange,
    BookingStatus.approved => Colors.green,
    BookingStatus.rejected => Colors.red,
  };
}
