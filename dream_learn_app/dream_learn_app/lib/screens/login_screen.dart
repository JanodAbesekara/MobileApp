import 'package:dream_learn_app/helpers/student_helper.dart';
import 'package:dream_learn_app/models/login_data_model.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/screens/main_home2.dart';
import 'package:dream_learn_app/services/auth_service.dart';
import 'package:dream_learn_app/utils/text_field.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const _loginTextStyles = TextStyle(
      color: Color(0xff4E919A),
      fontSize: 20,
      letterSpacing: 10,
      fontWeight: FontWeight.bold);

  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

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
          child: CommonTextField(
            hintText: 'User name',
            controller: _userNameTextController,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CommonTextField(
              isObscureText: true,
              hintText: 'Password',
              controller: _passwordTextController,
            )),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: 277,
          child: ElevatedButton(
            onPressed: () => _handleLogin(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 43, 29, 168)),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        const HoverText(
          text: 'Forgot Password? Click here to reset',
          url: "https://byte-group-project.vercel.app/login",
        ),
        const SizedBox(
          height: 25,
        ),
        const HoverText(
          text: 'New? Create An Account',
          url: "https://byte-group-project.vercel.app/Registrationform",
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  _handleLogin(BuildContext context) async {
    LoginDataModel authResponse = await AuthService.login(
        _userNameTextController.text, _passwordTextController.text);
    if (authResponse.success && authResponse.token != null) {
      studentEmail=_userNameTextController.text;
      var snackBar = SnackBar(
        content: Align(
          alignment: Alignment.center,
          child: Text(authResponse.message),
        ),
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MainHome2()));
    } else {
      var snackBar = SnackBar(
        content: Align(
          alignment: Alignment.center,
          child: Text(authResponse.message),
        ),
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(child: _passChild(context));
  }
}

class HoverText extends StatefulWidget {
  final String text;
  final String url;

  const HoverText({super.key, required this.text, required this.url});

  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _launchURL(widget.url);
        },
        child: Text(
          widget.text,
          style: TextStyle(
            color: _isHovering ? Colors.blue : Colors.black,
            fontWeight: widget.text == 'New? Create An Account' ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
