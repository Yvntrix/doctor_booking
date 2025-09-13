import 'package:bloc/bloc.dart';
import 'package:doctor_booking/domain/entities/booking_entity.dart';
import 'package:doctor_booking/domain/repositories/booking_repository.dart';
import 'package:doctor_booking/utils/ui/booking_filter_bar.dart';
import 'package:equatable/equatable.dart';

part 'my_bookings_state.dart';

class MyBookingsCubit extends Cubit<MyBookingsState> {
  MyBookingsCubit(this._bookingRepository) : super(const MyBookingsState.initial()) {
    fetchBookings();
  }

  final BookingRepository _bookingRepository;

  Future<void> fetchBookings() async {
    emit(state.copyWith(status: MyBookingsStatus.loading));
    try {
      final bookings = _bookingRepository.getAllBookings();

      emit(
        state.copyWith(
          status: MyBookingsStatus.success,
          bookings: bookings,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: MyBookingsStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  void setFilter(BookingFilter filter) {
    emit(state.copyWith(filter: filter));
  }


  
}
