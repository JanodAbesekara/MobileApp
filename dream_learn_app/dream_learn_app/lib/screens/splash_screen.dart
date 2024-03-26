import 'package:dream_learn_app/screens/background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:more_loading_gif/more_loading_gif.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});


static const _loginTextStyles = TextStyle(color: Color(0xff4E919A), fontSize: 20, letterSpacing: 10, fontWeight: FontWeight.bold);



Widget _passChild() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 60.0), // Adjust the value as needed
          child: Image.asset(
            "assets/children.png",
            width: 280,
            height: 320,
          ),
        ),
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
