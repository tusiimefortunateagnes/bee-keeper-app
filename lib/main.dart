import '/splashscreen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/Services/notifi_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // dotenv.load(fileName: ".env");
  NotificationService().initNotification();
  runApp(const MaterialApp(
    home: Splashscreen(),
    debugShowCheckedModeBanner: false,
  ));
}
