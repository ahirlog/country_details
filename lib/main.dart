// ignore_for_file: deprecated_member_use

import 'package:country_details/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primaryColor: const Color(0xff31352E),
        primaryColorLight: const Color(0xff535E4B),
        primaryColorDark: const Color(0xff503440),
        hintColor: const Color(0xffAE9864),
      ),
      home: const SplashScreen(),
    );
  }
}
