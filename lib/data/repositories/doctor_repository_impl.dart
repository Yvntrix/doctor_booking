import 'package:doctor_booking/core/exceptions/repository_exception.dart';
import 'package:doctor_booking/data/sources/doctor_local_source.dart';
import 'package:doctor_booking/domain/entities/doctor_entity.dart';
import 'package:doctor_booking/domain/repositories/doctor_repository.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  DoctorRepositoryImpl(this.localSource);

  final DoctorLocalSource localSource;

  @override
  List<Doctor> getAllDoctors() {
    try {
      return localSource.getAllDoctors();
    } catch (e) {
      throw RepositoryException('Failed to fetch doctors', e);
    }
  }

  @override
  Doctor? getDoctorById(String id) {
    try {
      return localSource.getDoctorById(id);
    } catch (e) {
      throw RepositoryException('Failed to fetch doctor by ID', e);
    }
  }
}
