import 'package:doctor_booking/domain/entities/booking_entity.dart';
import 'package:doctor_booking/utils/date_utils.dart';
import 'package:doctor_booking/utils/string_utils.dart';
import 'package:flutter/material.dart';

class BookingDetailsCard extends StatelessWidget {
  const BookingDetailsCard({required this.booking, super.key, this.onTap});
  final Booking booking;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: Icon(Icons.calendar_today, color: booking.status.color),
        title: Text(booking.patientName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${booking.date.formattedDate}'),
            Text('Time: ${booking.slotStart.formatTime()} - ${booking.slotEnd.formatTime()}'),
            Text('Reason: ${booking.reason}'),
          ],
        ),
        trailing: Chip(
          label: Text(
            booking.status.label(context),
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: booking.status.color,
        ),
        onTap: onTap,
      ),
    );
  }
}
