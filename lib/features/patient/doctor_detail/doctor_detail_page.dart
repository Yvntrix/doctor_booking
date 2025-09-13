import 'package:doctor_booking/core/router/app_router.dart';
import 'package:doctor_booking/domain/entities/doctor_entity.dart';
import 'package:doctor_booking/domain/repositories/doctor_repository.dart';
import 'package:doctor_booking/features/patient/doctor_detail/cubit/doctor_detail_cubit.dart';
import 'package:doctor_booking/features/patient/doctor_detail/widgets/doctor_availability_card.dart';
import 'package:doctor_booking/utils/string_utils.dart';
import 'package:doctor_booking/utils/ui/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailPage extends StatelessWidget {
  const DoctorDetailPage({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Detail'),
      ),
      body: BlocProvider(
        create: (context) => DoctorDetailCubit(
          id,
          context.read<DoctorRepository>(),
        ),
        child: const DoctorDetailView(),
      ),
    );
  }
}

class DoctorDetailView extends StatelessWidget {
  const DoctorDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDetailCubit, DoctorDetailState>(
      builder: (context, state) {
        final status = state.status;
        if (status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (status.isFailure) {
          return Center(child: Text(state.error ?? 'Failed to load doctor details'));
        }

        if (status.isSuccess && state.doctor == null) {
          return const Center(child: Text('Doctor not found'));
        }

        if (state.status.isSuccess) {
          final doctor = state.doctor!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                _header(doctor),
                _availability(doctor.availability),
                _book(context, doctor.id),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _header(Doctor doctor) => Row(
    children: [
      ProfilePic(size: 32, initials: doctor.name.initial),
      const SizedBox(width: 20),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctor.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              doctor.specialty,
              style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _availability(List<DoctorAvailability> availability) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Availability',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      for (final a in availability) ...[
        DoctorAvailabilityCard(availability: a),
      ],
    ],
  );

  Widget _book(BuildContext context, String id) => SafeArea(
    child: Center(
      child: ElevatedButton.icon(
        onPressed: () => context.goToBookingForm(id),
        icon: const Icon(Icons.calendar_today),
        label: const Text('Book Appointment'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: const TextStyle(fontSize: 18),
        ),
      ),
    ),
  );
}
