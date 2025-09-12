part of 'doctor_list_cubit.dart';

enum DoctorListStatus { initial, loading, success, failure }

extension DoctorListStatusX on DoctorListStatus {
  bool get isInitial => this == DoctorListStatus.initial;
  bool get isLoading => this == DoctorListStatus.loading;
  bool get isSuccess => this == DoctorListStatus.success;
  bool get isFailure => this == DoctorListStatus.failure;
}

class DoctorListState extends Equatable {
  const DoctorListState({
    required this.status,
    required this.doctors,
    required this.error,
  });

  const DoctorListState.initial() : status = DoctorListStatus.initial, doctors = const [], error = null;

  DoctorListState copyWith({
    DoctorListStatus? status,
    List<Doctor>? doctors,
    String? error,
  }) {
    return DoctorListState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      error: error ?? this.error,
    );
  }

  final DoctorListStatus status;
  final List<Doctor> doctors;
  final String? error;

  @override
  List<Object?> get props => [
    status,
    doctors,
    error,
  ];
}
