import 'package:doctor_booking/core/router/app_router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Doctor Booking App',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
