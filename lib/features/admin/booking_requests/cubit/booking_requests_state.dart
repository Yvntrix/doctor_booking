part of 'booking_requests_cubit.dart';

enum BookingRequestsStatus { initial, loading, success, failure }

extension BookingRequestsStatusX on BookingRequestsStatus {
  bool get isInitial => this == BookingRequestsStatus.initial;
  bool get isLoading => this == BookingRequestsStatus.loading;
  bool get isSuccess => this == BookingRequestsStatus.success;
  bool get isFailure => this == BookingRequestsStatus.failure;
}

class BookingRequestsState extends Equatable {
  const BookingRequestsState({
    required this.status,
    required this.bookings,
    required this.error,
    required this.filter,
  });

  const BookingRequestsState.initial()
    : status = BookingRequestsStatus.initial,
      bookings = const [],
      error = null,
      filter = BookingFilter.all;

  BookingRequestsState copyWith({
    BookingRequestsStatus? status,
    List<Booking>? bookings,
    String? error,
    BookingFilter? filter,
  }) {
    return BookingRequestsState(
      status: status ?? this.status,
      bookings: bookings ?? this.bookings,
      error: error ?? this.error,
      filter: filter ?? this.filter,
    );
  }

  List<Booking> get filteredBookings {
    switch (filter) {
      case BookingFilter.all:
        return bookings;
      case BookingFilter.pending:
        return bookings.where((b) => b.status.name == 'pending').toList();
      case BookingFilter.approved:
        return bookings.where((b) => b.status.name == 'approved').toList();
      case BookingFilter.rejected:
        return bookings.where((b) => b.status.name == 'rejected').toList();
    }
  }

  final BookingRequestsStatus status;
  final List<Booking> bookings;
  final BookingFilter filter;
  final String? error;

  @override
  List<Object?> get props => [status, bookings, error, filter];
}
