import 'package:dream_learn_app/screens/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactUS extends StatelessWidget {
  const ContactUS({super.key});

  static final TextStyle _titleStyles = TextStyle(
    color: Colors.black.withOpacity(0.7),
    fontSize: 28,
    letterSpacing: 2,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle _contactDetailsStyles = TextStyle(
    color: Colors.black87,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle _contactSubDetailsStyles = TextStyle(
    color: Colors.black87,
    fontSize: 16,
  );

  Widget _textContainer(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: child,
    );
  }

  Widget _passChild() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xffD9D9D9).withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Contact Us',
                style: _titleStyles,
              ),
            ),
          ),
          const SizedBox(height: 50),
          _textContainer(
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Telephone - ',
                  style: _contactDetailsStyles,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '(011) 123 4567',
                      style: _contactDetailsStyles,
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _textContainer(
            Text(
              'Email - dreamlearnacademy@gmail.com',
              style: _contactDetailsStyles,
            ),
          ),
          const SizedBox(height: 20),
          _textContainer(
            Text(
              'Address - No 37/1, Galle Road, Dehiwala, Sri Lanka',
              style: _contactDetailsStyles,
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _passChild(),
      ),
    );
  }
}
