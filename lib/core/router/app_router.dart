import 'package:doctor_booking/features/admin/booking_detail/booking_detail_page.dart';
import 'package:doctor_booking/features/admin/booking_requests/booking_requests_page.dart';
import 'package:doctor_booking/features/home/home_page.dart';
import 'package:doctor_booking/features/patient/booking_form/booking_form_page.dart';
import 'package:doctor_booking/features/patient/doctor_detail/doctor_detail_page.dart';
import 'package:doctor_booking/features/patient/doctor_list/doctor_list_page.dart';
import 'package:doctor_booking/features/patient/my_bookings/my_bookings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension AppRouterX on BuildContext {
  // Patient
  void goToPatient() => go('/patient');
  void goToDoctorDetail(String id) => push('/patient/doctor/$id');
  void goToBookingForm(String id) => push('/patient/doctor/$id/booking');
  void goToMyBookings() => push('/patient/my-bookings');

  // Admin
  void goToAdmin() => go('/admin');
  void goToBookingDetail(String id) => push('/admin/booking/$id');
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'patient',
          builder: (context, state) => const DoctorListPage(),
          routes: [
            GoRoute(
              path: 'doctor/:id',
              builder: (context, state) => DoctorDetailPage(
                id: state.pathParameters['id']!,
              ),
              routes: [
                GoRoute(
                  path: 'booking',
                  builder: (context, state) => BookingFormPage(
                    id: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'my-bookings',
              builder: (context, state) => const MyBookingsPage(),
            ),
          ],
        ),
        GoRoute(
          path: 'admin',
          builder: (context, state) => const BookingRequestsPage(),
          routes: [
            GoRoute(
              path: 'booking/:id',
              builder: (context, state) => const BookingDetailPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
