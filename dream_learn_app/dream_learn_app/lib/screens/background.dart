import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackgroundScreen extends StatelessWidget {
  final Widget child;
  const BackgroundScreen({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:AppBar(
      //   backgroundColor: Colors.purple,
      //   title: Text('example app'),     ) ,
      body: SafeArea(
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Image.asset("assets/logo.png"),
                child,
                Text(
                  'Tuition class Management System',
                  style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey, decoration: TextDecoration.underline)),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
