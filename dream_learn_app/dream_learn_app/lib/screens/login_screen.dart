import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/utils/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const _loginTextStyles = TextStyle(color: Color(0xff4E919A), fontSize: 20, letterSpacing: 10, fontWeight: FontWeight.bold);

  Widget _passChild() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Image.asset(
          "assets/profile_avatar.png",
          width: 107,
          height: 106,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'LOGIN',
          style: _loginTextStyles,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Sign into your account',
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: CommonTextField(hintText: 'User name'),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 50), child: CommonTextField(hintText: 'Password')),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: 272,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff46498F)),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: () {
            print('i forgot password');
          },
          child: const Text(
            'Forgot Password? Click here to reset',
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: () {
            print('create account');
          },
          child: const Text(
            ' New? Create An Account',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(child: _passChild());
  }
}
