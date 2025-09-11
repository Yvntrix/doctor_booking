import 'package:flutter/material.dart';

class DoctorDetailPage extends StatelessWidget {
  const DoctorDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Detail'),
      ),
      body: const Center(
        child: Text('Doctor Detail Page'),
      ),
    );
  }
}
