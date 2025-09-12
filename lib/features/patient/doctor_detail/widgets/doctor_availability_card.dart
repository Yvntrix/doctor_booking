import 'package:doctor_booking/domain/entities/doctor_entity.dart';
import 'package:flutter/material.dart';

class DoctorAvailabilityCard extends StatelessWidget {
  const DoctorAvailabilityCard({required this.availability, super.key});
  final DoctorAvailability availability;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                availability.day,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: availability.slots.isEmpty
                  ? const Text('Not available', style: TextStyle(color: Colors.redAccent))
                  : Wrap(
                      spacing: 8,
                      children: [
                        for (final s in availability.slots)
                          Chip(
                            side: BorderSide.none,
                            label: Text('${s.startTime} - ${s.endTime}'),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
