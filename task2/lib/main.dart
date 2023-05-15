import "package:flutter/material.dart";
import "package:task2/landing_page.dart";
import "package:task2/login.dart";
import 'package:task2/signup_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'main',
    routes: {
      'main': (context) => const MainPage(),
      'login': (context) => const LoginPage(),
      'signup': (context) => const SignupPage()
    },
  ));
}
