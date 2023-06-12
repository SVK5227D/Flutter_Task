import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btnName;
  final Function callBack;
  final dynamic value;
  const MyButton(
      {super.key,
      required this.btnName,
      required this.callBack,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          callBack(value, btnName);
        },
        child: Text(btnName));
  }
}
