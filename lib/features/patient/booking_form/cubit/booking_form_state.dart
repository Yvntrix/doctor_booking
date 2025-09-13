part of 'booking_form_cubit.dart';

enum BookingFormStatus { initial, loading, submitting, success, failure }

extension BookingFormStatusX on BookingFormStatus {
  bool get isInitial => this == BookingFormStatus.initial;
  bool get isLoading => this == BookingFormStatus.loading;
  bool get isSubmitting => this == BookingFormStatus.submitting;
  bool get isSuccess => this == BookingFormStatus.success;
  bool get isFailure => this == BookingFormStatus.failure;
}

class BookingFormState extends Equatable {
  const BookingFormState({
    required this.status,
    required this.patientName,
    required this.reason,
    required this.selectedDate,
    required this.error,
    required this.doctor,
    required this.selectedSlot,
  });

  const BookingFormState.initial()
    : status = BookingFormStatus.initial,
      patientName = '',
      reason = '',
      selectedDate = null,
      error = null,
      doctor = null,
      selectedSlot = null;

  BookingFormState copyWith({
    BookingFormStatus? status,
    String? patientName,
    String? reason,
    DateTime? selectedDate,
    Doctor? doctor,
    DoctorSlot? selectedSlot,
    String? error,
  }) {
    final clearError = error == null && this.error != null;
    return BookingFormState(
      status: status ?? this.status,
      patientName: patientName ?? this.patientName,
      reason: reason ?? this.reason,
      selectedDate: selectedDate ?? this.selectedDate,
      doctor: doctor ?? this.doctor,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      error: clearError ? null : error ?? this.error,
    );
  }

  Set<String> get availableDays => doctor?.availability.map((a) => a.day).toSet() ?? {};

  List<DoctorSlot> get availableSlots {
    if (doctor == null || selectedDate == null) return [];
    final selectedDay = selectedDate!.weekdayName;

    final availability = doctor!.availability.firstWhere(
      (a) => a.day.toLowerCase() == selectedDay.toLowerCase(),
      orElse: () => DoctorAvailability(day: selectedDay, slots: []),
    );

    return availability.slots;
  }

  final BookingFormStatus status;
  final String patientName;
  final String reason;
  final DateTime? selectedDate;
  final Doctor? doctor;
  final DoctorSlot? selectedSlot;
  final String? error;

  @override
  List<Object?> get props => [status, patientName, reason, selectedDate, doctor, selectedSlot, error];
}
