import 'package:doctor_booking/core/router/app_router.dart';
import 'package:doctor_booking/core/services/hive_service.dart';
import 'package:doctor_booking/data/repositories/booking_repository_impl.dart';
import 'package:doctor_booking/data/repositories/doctor_repository_impl.dart';
import 'package:doctor_booking/data/sources/booking_local_source.dart';
import 'package:doctor_booking/data/sources/doctor_local_source.dart';
import 'package:doctor_booking/domain/repositories/booking_repository.dart';
import 'package:doctor_booking/domain/repositories/doctor_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BookingRepository>(
          create: (context) => BookingRepositoryImpl(
            BookingLocalSource(
              HiveService.bookingBox,
            ),
          ),
        ),
        RepositoryProvider<DoctorRepository>(
          create: (context) => DoctorRepositoryImpl(
            DoctorLocalSource(
              HiveService.doctorBox,
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Doctor Booking App',
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
