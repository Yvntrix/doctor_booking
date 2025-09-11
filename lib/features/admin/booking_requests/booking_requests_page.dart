import 'package:flutter/material.dart';

class BookingRequestsPage extends StatelessWidget {
  const BookingRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Requests'),
      ),
      body: const Center(
        child: Text('Booking Requests Page'),
      ),
    );
  }
}
