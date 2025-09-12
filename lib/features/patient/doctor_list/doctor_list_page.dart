import 'package:doctor_booking/core/router/app_router.dart';
import 'package:doctor_booking/domain/repositories/doctor_repository.dart';
import 'package:doctor_booking/features/patient/doctor_list/cubit/doctor_list_cubit.dart';
import 'package:doctor_booking/utils/ui/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorListPage extends StatelessWidget {
  const DoctorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorListCubit(context.read<DoctorRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Doctor List'),
        ),
        body: const DoctorListView(),
      ),
    );
  }
}

class DoctorListView extends StatelessWidget {
  const DoctorListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorListCubit, DoctorListState>(
      builder: (context, state) {
        final status = state.status;

        if (status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (status.isFailure) {
          return Center(child: Text(state.error ?? 'Failed to load doctors'));
        }
        if (status.isSuccess && state.doctors.isEmpty) {
          return const Center(child: Text('No doctors found.'));
        }
        if (status.isSuccess) {
          return ListView.builder(
            itemCount: state.doctors.length,
            itemBuilder: (context, index) {
              final doctor = state.doctors[index];
              return ListTile(
                leading: ProfilePic(size: 24, initials: doctor.initials),
                title: Text(
                  doctor.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(doctor.specialty),
                onTap: () => context.goToDoctorDetail(doctor.id),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
