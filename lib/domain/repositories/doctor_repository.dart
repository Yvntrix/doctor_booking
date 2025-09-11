import 'package:doctor_booking/domain/entities/doctor_entity.dart';

abstract class DoctorRepository {
  List<Doctor> getAllDoctors();
  Doctor? getDoctorById(String id);
}
