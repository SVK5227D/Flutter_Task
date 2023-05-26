import 'package:test1/sample2.dart';
import 'package:flutter/material.dart';

class ScreenSample extends StatefulWidget {
  const ScreenSample({super.key});

  @override
  State<ScreenSample> createState() => _ScreenSampleState();
}

class _ScreenSampleState extends State<ScreenSample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: const Text('Sample Navigation'),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  color: Colors.purple.shade300,
                  height: 30,
                  width: 90,
                  child: GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(context, MaterialPageRoute(
                        //   builder: (context) {
                        //     return ScreenSample2();
                        //   },
                        // ));
                        Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: const Duration(seconds: 1),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation secondaryAnimation,
                              Widget child) {
                            animation = CurvedAnimation(
                                parent: animation, curve: Curves.slowMiddle);
                            return ScaleTransition(
                              scale: animation,
                              alignment: Alignment.center,
                              child: child,
                            );
                          },
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation secondaryAnimation) {
                            return const ScreenSample2();
                          },
                        ));
                      },
                      child: const Center(
                          child: Text(
                        'Next Page',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ))))
            ],
          ),
        ),
      ),
    );
  }
}
