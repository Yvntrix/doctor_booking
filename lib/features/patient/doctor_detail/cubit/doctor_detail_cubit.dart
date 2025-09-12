import 'package:bloc/bloc.dart';
import 'package:doctor_booking/domain/entities/doctor_entity.dart';
import 'package:doctor_booking/domain/repositories/doctor_repository.dart';
import 'package:equatable/equatable.dart';

part 'doctor_detail_state.dart';

class DoctorDetailCubit extends Cubit<DoctorDetailState> {
  DoctorDetailCubit(this._id, this._doctorRepository) : super(const DoctorDetailState.initial()) {
    fetchDoctorDetail();
  }

  final String _id;
  final DoctorRepository _doctorRepository;

  Future<void> fetchDoctorDetail() async {
    emit(state.copyWith(status: DoctorDetialStatus.loading));
    try {
      final doctor = _doctorRepository.getDoctorById(_id);
      if (doctor != null) {
        emit(state.copyWith(status: DoctorDetialStatus.success, doctor: doctor));
      } else {
        emit(state.copyWith(status: DoctorDetialStatus.failure, error: 'Doctor not found'));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: DoctorDetialStatus.failure, error: e.toString()));
    }
  }
}
