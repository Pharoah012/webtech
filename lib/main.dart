import 'package:flutter/material.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect with us',
      theme: ThemeData(
        primaryColor: kPrimary,
      ),
      home: const SplashScreen());
  }
}
