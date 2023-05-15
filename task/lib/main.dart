import 'Field/input_field.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InputField(),
    );
  }
}

// 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
