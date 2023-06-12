import 'package:test1/button.dart';
import 'package:flutter/material.dart';

class SampleText extends StatefulWidget {
  const SampleText({super.key});

  @override
  State<SampleText> createState() => _SampleTextState();
}

class _SampleTextState extends State<SampleText> {
  String btnName = 'Sample';

  changeName(name) {
    setState(() {
      btnName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                width: 300,
                height: 60,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.blue),
                margin: const EdgeInsets.only(
                  top: 50,
                ),
                child: Center(
                  child: Text(
                    'Sample Text $btnName',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              // MyButton(btnName: 'Button1', callBack: changeName),
              // MyButton(btnName: 'Button2', callBack: changeName),
              // MyButton(btnName: 'Button3', callBack: changeName),
              // MyButton(btnName: 'Button4', callBack: changeName),
            ],
          ),
        ),
      ),
    );
  }
}
