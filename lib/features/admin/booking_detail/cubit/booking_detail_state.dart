part of 'booking_detail_cubit.dart';

enum BookingDetailStatus { initial, loading, loaded, error }

extension BookingDetailStatusX on BookingDetailStatus {
  bool get isInitial => this == BookingDetailStatus.initial;
  bool get isLoading => this == BookingDetailStatus.loading;
  bool get isSuccess => this == BookingDetailStatus.loaded;
  bool get isFailure => this == BookingDetailStatus.error;
}

class BookingDetailState extends Equatable {
  const BookingDetailState({
    required this.status,
    required this.booking,
    required this.doctor,
    required this.error,
  });

  const BookingDetailState.initial()
    : status = BookingDetailStatus.initial,
      booking = null,
      doctor = null,
      error = null;

  BookingDetailState copyWith({
    BookingDetailStatus? status,
    Doctor? doctor,
    Booking? booking,
    String? error,
  }) {
    return BookingDetailState(
      status: status ?? this.status,
      doctor: doctor ?? this.doctor,
      booking: booking ?? this.booking,
      error: error ?? this.error,
    );
  }

  final BookingDetailStatus status;
  final Doctor? doctor;
  final Booking? booking;
  final String? error;

  @override
  List<Object?> get props => [
    status,
    booking,
    doctor,
    error,
  ];
}
