import 'package:doctor_booking/domain/repositories/booking_repository.dart';
import 'package:doctor_booking/domain/repositories/doctor_repository.dart';
import 'package:doctor_booking/features/patient/booking_form/cubit/booking_form_cubit.dart';
import 'package:doctor_booking/utils/date_utils.dart';
import 'package:doctor_booking/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingFormPage extends StatelessWidget {
  const BookingFormPage({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Form')),
      body: BlocProvider(
        create: (context) => BookingFormCubit(
          context.read<BookingRepository>(),
          context.read<DoctorRepository>(),
          id,
        ),
        child: const BookingFormView(),
      ),
    );
  }
}

class BookingFormView extends StatelessWidget {
  const BookingFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingFormCubit, BookingFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;

        if (status.isFailure) {
          context.showSnackbar(state.error ?? 'An error occurred', type: SnackbarType.error);
        } else if (status.isSuccess) {
          context.showSnackbar('Booking successful', type: SnackbarType.success);
          Navigator.of(context).pop();
        }
      },

      builder: (context, state) {
        final cubit = context.read<BookingFormCubit>();
        final status = state.status;

        if (status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (status.isFailure && state.doctor == null) {
          return Center(child: Text(state.error ?? 'Failed to load doctor details'));
        }

        if (state.doctor == null) {
          return const Center(child: Text('Doctor not found'));
        }

        return Form(
          key: cubit.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 12,
              children: [
                _patientName(cubit),
                _reasonForVisit(cubit),
                _selectDate(context, state, cubit),
                const Text('Available Slots:', style: TextStyle(fontWeight: FontWeight.bold)),
                _slotChips(state, cubit),
                ElevatedButton(
                  onPressed: cubit.submitBooking,
                  child: const Text('Submit Booking'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _patientName(BookingFormCubit cubit) => TextFormField(
    controller: cubit.patientNameController,
    decoration: const InputDecoration(labelText: 'Patient Name'),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter patient name';
      }
      return null;
    },
  );

  Widget _reasonForVisit(BookingFormCubit cubit) => TextFormField(
    controller: cubit.reasonController,
    decoration: const InputDecoration(labelText: 'Reason for Visit'),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter reason for visit';
      }
      return null;
    },
  );

  Widget _selectDate(BuildContext context, BookingFormState state, BookingFormCubit cubit) => ListTile(
    title: const Text('Select Date'),
    subtitle: Text(
      state.selectedDate == null ? 'Tap to select' : '${state.selectedDate?.formattedDate}',
    ),
    onTap: () async {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: state.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
        selectableDayPredicate: (date) => state.availableDays.contains(date.weekdayName),
      );
      if (pickedDate != null) {
        cubit.updateDate(pickedDate);
      }
    },
  );

  Widget _slotChips(BookingFormState state, BookingFormCubit cubit) => Wrap(
    spacing: 8,
    children: [
      for (final slot in state.availableSlots)
        ChoiceChip(
          showCheckmark: false,
          label: Text('${slot.startTime} - ${slot.endTime}'),
          selected: state.selectedSlot == slot,
          onSelected: (_) => cubit.selectSlot(slot),
        ),
    ],
  );
}
