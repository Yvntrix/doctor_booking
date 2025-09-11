import 'package:doctor_booking/core/exceptions/local_source_exception.dart';
import 'package:doctor_booking/data/tables/doctors/doctor_table.dart';
import 'package:doctor_booking/data/tables/doctors/doctor_table_extensions.dart';
import 'package:doctor_booking/domain/entities/doctor_entity.dart';
import 'package:hive_ce_flutter/adapters.dart';

class DoctorLocalSource {
  DoctorLocalSource(this._box);

  final Box<DoctorTable> _box;

  List<Doctor> getAllDoctors() {
    try {
      return _box.values.map((t) => t.toDomain()).toList();
    } catch (e) {
      throw LocalSourceException('Error fetching doctors', e);
    }
  }

  Doctor? getDoctorById(String id) {
    try {
      final doctorTable = _box.get(id);
      return doctorTable?.toDomain();
    } catch (e) {
      throw LocalSourceException('Error fetching doctor $id', e);
    }
  }
}
