part of 'doctor_detail_cubit.dart';

enum DoctorDetialStatus { initial, loading, success, failure }

extension DoctorDetailStatusX on DoctorDetialStatus {
  bool get isInitial => this == DoctorDetialStatus.initial;
  bool get isLoading => this == DoctorDetialStatus.loading;
  bool get isSuccess => this == DoctorDetialStatus.success;
  bool get isFailure => this == DoctorDetialStatus.failure;
}

class DoctorDetailState extends Equatable {
  const DoctorDetailState({
    required this.status,
    required this.doctor,
    required this.error,
  });

  const DoctorDetailState.initial() : status = DoctorDetialStatus.initial, doctor = null, error = null;

  DoctorDetailState copyWith({
    DoctorDetialStatus? status,
    Doctor? doctor,
    String? error,
  }) {
    return DoctorDetailState(
      status: status ?? this.status,
      doctor: doctor ?? this.doctor,
      error: error ?? this.error,
    );
  }

  final DoctorDetialStatus status;
  final Doctor? doctor;
  final String? error;

  @override
  List<Object?> get props => [
    status,
    doctor,
    error,
  ];
}
