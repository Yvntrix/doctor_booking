import 'package:bloc/bloc.dart';
import 'package:doctor_booking/domain/entities/booking_entity.dart';
import 'package:doctor_booking/domain/repositories/booking_repository.dart';
import 'package:doctor_booking/utils/ui/booking_filter_bar.dart';
import 'package:equatable/equatable.dart';

part 'booking_requests_state.dart';

class BookingRequestsCubit extends Cubit<BookingRequestsState> {
  BookingRequestsCubit(this._bookingRepository) : super(const BookingRequestsState.initial()) {
    fetchBookingRequests();
  }

  final BookingRepository _bookingRepository;

  Future<void> fetchBookingRequests() async {
    emit(state.copyWith(status: BookingRequestsStatus.loading));
    try {
      final bookings = _bookingRepository.getAllBookings();

      emit(
        state.copyWith(
          status: BookingRequestsStatus.success,
          bookings: bookings,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: BookingRequestsStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  void setFilter(BookingFilter filter) {
    emit(state.copyWith(filter: filter));
  }
}
