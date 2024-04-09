import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/utils/text_field.dart';
import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/main_home2.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const _loginTextStyles = TextStyle(
    color: Color(0xff4E919A),
    fontSize: 20,
    letterSpacing: 10,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _passChild(context),
    );
  }

  Widget _passChild(BuildContext context) {
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: CommonTextField(hintText: 'User name'),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: CommonTextField(hintText: 'Password'),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: 272,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainHome2()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff46498F),
            ),
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
}
