import "package:flutter/material.dart";
import 'package:task2/page/dashboard.dart';
import 'package:task2/page/login_page.dart';
import "package:task2/page/signup_page.dart";
import "package:task2/page/landing_page.dart";
// import "package:task2/try.dart";

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'main',
    routes: {
      'main': (context) => const MainPage(),
      'login': (context) => const LoginPage(),
      'signup': (context) => const SignupPage(),
      'checkData': (context) => const UserDashBoard(
          )
    },
  ));
}
