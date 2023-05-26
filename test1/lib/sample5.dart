import 'package:test1/webview.dart';
import 'package:flutter/material.dart';

class InAppWeb extends StatelessWidget {
  const InAppWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
              color: Colors.amber,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const SamplePageFour();
                      },
                    ));
                  },
                  child: const Text(
                    'W3School',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ))),
        ),
      ),
    );
  }
}
