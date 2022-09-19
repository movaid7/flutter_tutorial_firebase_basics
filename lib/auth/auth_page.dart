import 'package:firebase_basics/pages/login_page.dart';
import 'package:firebase_basics/pages/register_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // initially show login page
  bool showLogin = true;

  void toggleView() {
    setState(() {
      showLogin = !showLogin;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(showRegisterPage: toggleView);
    } else {
      return RegisterPage(showLoginPage: toggleView);
    }
  }
}
