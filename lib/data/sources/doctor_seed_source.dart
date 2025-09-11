import 'dart:convert';
import 'package:doctor_booking/data/tables/doctors/doctor_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class DoctorSeedSource {
  DoctorSeedSource(this.box);
  final Box<DoctorTable> box;

  Future<void> seedIfEmpty() async {
    debugPrint('Doctors already in Hive: ${box.length}');

    if (box.isNotEmpty) return;

    final jsonString = await rootBundle.loadString('assets/data/doctors.json');
    final data = json.decode(jsonString) as List<dynamic>;
    final doctors = data
        .map(
          (d) => DoctorTable.fromJson(d as Map<String, dynamic>),
        )
        .toList();

    await box.putAll({for (final doc in doctors) doc.id: doc});

    debugPrint('Seeded ${doctors.length} doctors into Hive database.');
  }
}
