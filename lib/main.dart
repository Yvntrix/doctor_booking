import 'package:doctor_booking/core/app/app.dart';
import 'package:doctor_booking/core/services/hive_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  runApp(const App());
}
