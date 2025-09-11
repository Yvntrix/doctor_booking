import 'package:flutter/material.dart';

class DoctorListPage extends StatelessWidget {
  const DoctorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor List'),
      ),
      body: const Center(
        child: Text('Doctor List Page'),
      ),
    );
  }
}
