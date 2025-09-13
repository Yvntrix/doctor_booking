import 'package:doctor_booking/domain/repositories/booking_repository.dart';
import 'package:doctor_booking/features/admin/booking_requests/cubit/booking_requests_cubit.dart';
import 'package:doctor_booking/utils/ui/booking_details_card.dart';
import 'package:doctor_booking/utils/ui/booking_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingRequestsPage extends StatelessWidget {
  const BookingRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Requests'),
      ),
      body: BlocProvider(
        create: (context) => BookingRequestsCubit(context.read<BookingRepository>()),
        child: const BookingRequestsView(),
      ),
    );
  }
}

class BookingRequestsView extends StatelessWidget {
  const BookingRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingRequestsCubit, BookingRequestsState>(
      builder: (context, state) {
        final cubit = context.read<BookingRequestsCubit>();
        final status = state.status;

        if (status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (status.isFailure) {
          return Center(child: Text(state.error ?? 'Failed to load booking requests'));
        }
        if (state.bookings.isEmpty) {
          return const Center(child: Text('No booking requests found.'));
        }
        return Column(
          children: [
            BookingFilterBar(
              selected: state.filter,
              onChanged: cubit.setFilter,
            ),
            Expanded(
              child: state.filteredBookings.isEmpty
                  ? const Center(child: Text('No booking requests found.'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.filteredBookings.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final booking = state.filteredBookings[index];
                        return BookingDetailsCard(
                          booking: booking,
                          onTap: () {},
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
