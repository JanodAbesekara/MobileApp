import 'package:dream_learn_app/screens/background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:more_loading_gif/more_loading_gif.dart';
import 'package:dream_learn_app/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const _loginTextStyles = TextStyle(
    color: Color(0xff4E919A),
    fontSize: 20,
    letterSpacing: 10,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(  // Wrap the entire page in a GestureDetector
      onTap: () => _navigateToLogin(context),
      child: BackgroundScreen(
        child: _passChild(context),
      ),
    );
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
          // Consider using a button instead (optional)
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

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
