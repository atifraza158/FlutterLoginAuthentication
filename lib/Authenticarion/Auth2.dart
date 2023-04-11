import 'package:flutter/material.dart';
import 'package:login_app/pages/SignUp_page.dart';
import 'package:login_app/pages/login_page.dart';

class Toggling extends StatefulWidget {
  const Toggling({super.key});

  @override
  State<Toggling> createState() => _TogglingState();
}

class _TogglingState extends State<Toggling> {
  bool showLoginScreen = true;

  void toggle() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginPage(signUpScreen: toggle);
    } else {
      return SignUpPage(SignInScreen: toggle);
    }
  }
}
