import 'dart:async';
import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:more_loading_gif/more_loading_gif.dart';

// new edit

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
            ModalRoute.withName("/login"));
     
  }

    startTime() async {
    var _duration = new Duration(seconds: 7);
    return new Timer(_duration, navigationPage);
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     startTime();
  }

  Widget _passChild() {
    return Column(
      children: [
        Image.asset(
          "assets/children.png",
          width: 300,
          height: 350,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Welcome You All !',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 10,
        ),
        const MoreLoadingGif(
          type: MoreLoadingGifType.spin,
          size: 50,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _passChild(),
    );
  }
}