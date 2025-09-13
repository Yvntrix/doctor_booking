import 'package:bloc/bloc.dart';
import 'package:doctor_booking/domain/entities/booking_entity.dart';
import 'package:doctor_booking/domain/entities/doctor_entity.dart';
import 'package:doctor_booking/domain/repositories/booking_repository.dart';
import 'package:doctor_booking/domain/repositories/doctor_repository.dart';
import 'package:equatable/equatable.dart';

part 'booking_detail_state.dart';

class BookingDetailCubit extends Cubit<BookingDetailState> {
  BookingDetailCubit(
    this._bookingId,
    this._doctorId,
    this._bookingRepository,
    this._doctorRepository,
  ) : super(const BookingDetailState.initial()) {
    fetchDoctor();
  }

  final String _bookingId;
  final String _doctorId;
  final BookingRepository _bookingRepository;
  final DoctorRepository _doctorRepository;

  void fetchDoctor() {
    emit(state.copyWith(status: BookingDetailStatus.loading));
    try {
      final doctor = _doctorRepository.getDoctorById(_doctorId);
      if (doctor == null) {
        emit(
          state.copyWith(status: BookingDetailStatus.error, error: 'Doctor not found'),
        );
        return;
      }
      emit(
        state.copyWith(status: BookingDetailStatus.loaded, doctor: doctor),
      );

      fetchBooking();
    } on Exception catch (e) {
      emit(
        state.copyWith(status: BookingDetailStatus.error, error: e.toString()),
      );
    }
  }

  void fetchBooking() {
    emit(state.copyWith(status: BookingDetailStatus.loading));
    try {
      final booking = _bookingRepository.getBookingById(_bookingId);
      if (booking == null) {
        emit(
          state.copyWith(status: BookingDetailStatus.error, error: 'Booking not found'),
        );
        return;
      }
      emit(
        state.copyWith(status: BookingDetailStatus.loaded, booking: booking),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(status: BookingDetailStatus.error, error: e.toString()),
      );
    }
  }

  Future<void> approveBooking() async {
    emit(state.copyWith(status: BookingDetailStatus.loading));
    try {
      final booking = await _bookingRepository.updateBookingStatus(_bookingId, BookingStatus.approved);

      if (booking == null) {
        emit(
          state.copyWith(status: BookingDetailStatus.error, error: 'Failed to approve booking'),
        );
        return;
      } else {
        emit(
          state.copyWith(status: BookingDetailStatus.loaded, booking: booking),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(status: BookingDetailStatus.error, error: e.toString()),
      );
    }
  }

  Future<void> rejectBooking() async {
    emit(state.copyWith(status: BookingDetailStatus.loading));
    try {
      final booking = await _bookingRepository.updateBookingStatus(_bookingId, BookingStatus.rejected);

      if (booking == null) {
        emit(
          state.copyWith(status: BookingDetailStatus.error, error: 'Failed to reject booking'),
        );
      } else {
        emit(
          state.copyWith(status: BookingDetailStatus.loaded, booking: booking),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(status: BookingDetailStatus.error, error: e.toString()),
      );
    }
  }
}
