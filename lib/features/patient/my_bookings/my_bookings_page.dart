import 'package:doctor_booking/domain/repositories/booking_repository.dart';
import 'package:doctor_booking/features/patient/my_bookings/cubit/my_bookings_cubit.dart';
import 'package:doctor_booking/utils/ui/booking_details_card.dart';
import 'package:doctor_booking/utils/ui/booking_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: BlocProvider(
        create: (context) => MyBookingsCubit(context.read<BookingRepository>()),
        child: const MyBookingsView(),
      ),
    );
  }
}

class MyBookingsView extends StatelessWidget {
  const MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBookingsCubit, MyBookingsState>(
      builder: (context, state) {
        final cubit = context.read<MyBookingsCubit>();
        final status = state.status;
        if (status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (status.isFailure) {
          return Center(child: Text(state.error ?? 'Failed to load bookings'));
        }
        if (state.bookings.isEmpty) {
          return const Center(child: Text('No bookings found.'));
        }

        return Column(
          children: [
            BookingFilterBar(
              selected: state.filter,
              onChanged: cubit.setFilter,
            ),
            Expanded(
              child: state.filteredBookings.isEmpty
                  ? const Center(child: Text('No bookings found.'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.filteredBookings.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final booking = state.filteredBookings[index];
                        return BookingDetailsCard(booking: booking);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
