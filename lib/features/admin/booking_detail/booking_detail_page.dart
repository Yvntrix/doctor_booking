import 'package:doctor_booking/domain/entities/booking_entity.dart';
import 'package:doctor_booking/domain/repositories/booking_repository.dart';
import 'package:doctor_booking/domain/repositories/doctor_repository.dart';
import 'package:doctor_booking/features/admin/booking_detail/cubit/booking_detail_cubit.dart';
import 'package:doctor_booking/utils/date_utils.dart';
import 'package:doctor_booking/utils/snackbar_utils.dart';
import 'package:doctor_booking/utils/string_utils.dart';
import 'package:doctor_booking/utils/ui/doctor_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDetailPage extends StatelessWidget {
  const BookingDetailPage({
    required this.bookingId,
    required this.doctorId,
    super.key,
  });
  final String bookingId;
  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Detail'),
      ),
      body: BlocProvider(
        create: (context) => BookingDetailCubit(
          bookingId,
          doctorId,
          context.read<BookingRepository>(),
          context.read<DoctorRepository>(),
        ),
        child: const BookingDetailView(),
      ),
    );
  }
}

class BookingDetailView extends StatelessWidget {
  const BookingDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingDetailCubit, BookingDetailState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        if (status.isSuccess) {
          context.showSnackbar('Booking updated successfully', type: SnackbarType.success);
        }
        if (status.isFailure) {
          context.showSnackbar(state.error ?? 'Failed to update booking', type: SnackbarType.error);
        }
      },
      builder: (context, state) {
        final cubit = context.read<BookingDetailCubit>();
        final status = state.status;

        if (status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (status.isFailure) {
          return Center(child: Text(state.error ?? 'Failed to load booking details'));
        }

        if (status.isSuccess && state.doctor == null) {
          return const Center(child: Text('Doctor not found'));
        }

        if (status.isSuccess && state.booking == null) {
          return const Center(child: Text('Booking not found'));
        }

        final booking = state.booking!;
        final doctor = state.doctor!;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              DoctorHeader(doctor: doctor),
              const Divider(),
              _detailRow(
                icon: Icons.person,
                label: 'Patient',
                value: booking.patientName,
              ),
              _detailRow(
                icon: Icons.calendar_today,
                label: 'Date',
                value: booking.date.formattedDate,
              ),
              _detailRow(
                icon: Icons.access_time,
                label: 'Time',
                value: '${booking.slotStart.formatTime()} - ${booking.slotEnd.formatTime()}',
              ),
              _detailRow(
                icon: Icons.info_outline,
                label: 'Reason',
                value: booking.reason,
              ),
              _detailStatus(context, booking),
              const SizedBox(height: 8),
              if (booking.status == BookingStatus.pending) ...[
                _buttons(cubit),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
  }) => Row(
    children: [
      Icon(icon, color: Colors.blueGrey),
      const SizedBox(width: 12),
      Text(
        '$label: ',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w400),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );

  Widget _detailStatus(BuildContext context, Booking booking) => Row(
    children: [
      Icon(booking.status.icon, color: booking.status.color),
      const SizedBox(width: 8),
      Text(
        booking.status.label(context),
        style: TextStyle(
          color: booking.status.color,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ],
  );

  Widget _actionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onPressed,
  ) => Expanded(
    child: ElevatedButton.icon(
      icon: Icon(icon, color: Colors.white, size: 18),
      label: Text(
        label.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: onPressed,
    ),
  );

  Widget _buttons(BookingDetailCubit cubit) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _actionButton(
        Icons.close,
        'Reject',
        Colors.red,
        cubit.rejectBooking,
      ),
      const SizedBox(width: 16),
      _actionButton(
        Icons.check,
        'Approve',
        Colors.green,
        cubit.approveBooking,
      ),
    ],
  );
}
