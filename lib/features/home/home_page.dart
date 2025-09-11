import 'package:doctor_booking/core/router/app_router.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Booking App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            const Padding(
              padding: EdgeInsets.all(48),
              child: Text(
                'Welcome! Please select your role to continue.',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                ElevatedButton.icon(
                  onPressed: context.goToAdmin,
                  icon: const Icon(Icons.admin_panel_settings),
                  label: const Text('I am an Admin'),
                ),
                ElevatedButton.icon(
                  onPressed: context.goToPatient,
                  icon: const Icon(Icons.person),
                  label: const Text('I am a Patient'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
