import 'package:doctor_booking/domain/entities/doctor_entity.dart';
import 'package:doctor_booking/utils/string_utils.dart';
import 'package:doctor_booking/utils/ui/profile_pic.dart';
import 'package:flutter/material.dart';

class DoctorHeader extends StatelessWidget {
  const DoctorHeader({required this.doctor, super.key});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePic(size: 32, initials: doctor.name.initial),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                doctor.specialty,
                style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
