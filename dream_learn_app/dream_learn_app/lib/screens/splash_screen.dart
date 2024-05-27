import 'dart:async';
import 'package:dream_learn_app/screens/background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:more_loading_gif/more_loading_gif.dart';
import 'package:dream_learn_app/screens/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void navigationPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      ModalRoute.withName("/login"),
    );
  }

  startTime() async {
    var _duration = const Duration(seconds: 7);
    return Timer(_duration, navigationPage);

  }

  @override
  void initState() {
    super.initState();
    startTime();
  }


  Widget _passChild(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 60.0), // Adjust as needed
            child: Image.asset(
              "assets/children.png",
              width: 280,
              height: 320,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Welcome You All!',
          style: GoogleFonts.inter(
            textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Container(  // No need for a separate GestureDetector here
          padding: const EdgeInsets.all(10.0), // Adjust padding if needed
          child: const MoreLoadingGif(
            type: MoreLoadingGifType.spin,
            size: 50,
          ),
        ),
        const SizedBox(height: 10),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _passChild(context),

    );
  }
}
