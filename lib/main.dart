import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '가을 책탑',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'NanumSquareRound',
        scaffoldBackgroundColor: const Color(0xFFFFF6D8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFD95A),
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
