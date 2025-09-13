part of 'my_bookings_cubit.dart';

enum MyBookingsStatus { initial, loading, success, failure }

extension MyBookingsStatusX on MyBookingsStatus {
  bool get isInitial => this == MyBookingsStatus.initial;
  bool get isLoading => this == MyBookingsStatus.loading;
  bool get isSuccess => this == MyBookingsStatus.success;
  bool get isFailure => this == MyBookingsStatus.failure;
}

class MyBookingsState extends Equatable {
  const MyBookingsState({
    required this.status,
    required this.bookings,
    required this.error,
    required this.filter,
  });

  const MyBookingsState.initial()
    : status = MyBookingsStatus.initial,
      bookings = const [],
      error = null,
      filter = BookingFilter.all;

  MyBookingsState copyWith({
    MyBookingsStatus? status,
    List<Booking>? bookings,
    String? error,
    BookingFilter? filter,
  }) {
    return MyBookingsState(
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

  final MyBookingsStatus status;
  final List<Booking> bookings;
  final String? error;
  final BookingFilter filter;

  @override
  List<Object?> get props => [status, bookings, error, filter];
}
