import 'package:bloc/bloc.dart';
import 'package:doctor_booking/domain/entities/doctor_entity.dart';
import 'package:doctor_booking/domain/repositories/doctor_repository.dart';
import 'package:equatable/equatable.dart';

part 'doctor_list_state.dart';

class DoctorListCubit extends Cubit<DoctorListState> {
  DoctorListCubit(this._doctorRepository) : super(const DoctorListState.initial()) {
    loadDoctors();
  }

  final DoctorRepository _doctorRepository;

  Future<void> loadDoctors() async {
    emit(state.copyWith(status: DoctorListStatus.loading));

    try {
      final doctors = _doctorRepository.getAllDoctors();
      emit(
        state.copyWith(status: DoctorListStatus.success, doctors: doctors),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(status: DoctorListStatus.failure, error: e.toString()),
      );
    }
  }
}
