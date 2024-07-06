
import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/screens/student_dashboard.dart';
import 'package:dream_learn_app/screens/side_bar.dart';
import 'package:dream_learn_app/screens/login_screen.dart';
import 'package:dream_learn_app/screens/main_home2.dart';
import 'package:dream_learn_app/screens/splash_screen.dart';
import 'package:dream_learn_app/screens/contact_us.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}