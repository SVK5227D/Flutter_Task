import 'package:test1/state.dart';
import 'package:flutter/material.dart';
// import 'package:test1/sample6.dart';
// import 'package:test1/sample5.dart';
// import 'package:test1/sample4.dart';
// import 'package:test1/sample3.dart';
// import 'package:test1/sample.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListItem(),
    );
  }
}
