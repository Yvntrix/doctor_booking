import 'package:bloc/bloc.dart';
import 'package:doctor_booking/domain/entities/doctor_entity.dart';
import 'package:doctor_booking/domain/repositories/booking_repository.dart';
import 'package:doctor_booking/domain/repositories/doctor_repository.dart';
import 'package:doctor_booking/utils/date_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'booking_form_state.dart';

class BookingFormCubit extends Cubit<BookingFormState> {
  BookingFormCubit(this._bookingRepository, this._doctorRepository, this._doctorId)
    : super(const BookingFormState.initial()) {
    loadDoctor();
    patientNameController.addListener(() {
      emit(state.copyWith(patientName: patientNameController.text));
    });
    reasonController.addListener(() {
      emit(state.copyWith(reason: reasonController.text));
    });
  }

  final BookingRepository _bookingRepository;
  final DoctorRepository _doctorRepository;
  final String _doctorId;

  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Future<void> close() {
    patientNameController.dispose();
    reasonController.dispose();
    return super.close();
  }

  void loadDoctor() {
    emit(state.copyWith(status: BookingFormStatus.loading));
    try {
      final doctor = _doctorRepository.getDoctorById(_doctorId);
      emit(state.copyWith(status: BookingFormStatus.initial, doctor: doctor));
    } on Exception catch (e) {
      emit(state.copyWith(status: BookingFormStatus.failure, error: e.toString()));
    }
  }

  void updateDate(DateTime selectedDate) {
    emit(state.copyWith(selectedDate: selectedDate));
  }

  void selectSlot(DoctorSlot slot) {
    emit(state.copyWith(selectedSlot: slot));
  }

  Future<void> submitBooking() async {
    emit(state.copyWith(status: BookingFormStatus.submitting));

    if (!formKey.currentState!.validate() || state.selectedDate == null || state.selectedSlot == null) {
      emit(state.copyWith(status: BookingFormStatus.failure, error: 'Please fill all fields and select a slot.'));
      return;
    }

    try {
      final booking = await _bookingRepository.createBooking(
        doctorId: _doctorId,
        patientName: state.patientName,
        date: state.selectedDate!,
        slotStart: state.selectedSlot!.start,
        slotEnd: state.selectedSlot!.end,
        reason: state.reason,
      );

      if (booking != null) {
        emit(state.copyWith(status: BookingFormStatus.success));
      } else {
        emit(state.copyWith(status: BookingFormStatus.failure, error: 'Failed to create booking.'));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: BookingFormStatus.failure, error: e.toString()));
    }
  }
}
