import 'package:flutter/material.dart';

class ScreenSample2 extends StatefulWidget {
  const ScreenSample2({super.key});

  @override
  State<ScreenSample2> createState() => _ScreenSample2State();
}

class _ScreenSample2State extends State<ScreenSample2> {
  bool isPhone(BuildContext context) => MediaQuery.of(context).size.width < 600;
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;
  @override
  Widget build(BuildContext context) =>
      OrientationBuilder(builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(),
            body: GridView.count(
              crossAxisCount: isPortrait ? 2 : 4,
              children: List.generate(
                  30,
                  (index) => Card(
                        color: Colors.amber,
                        child: Center(
                          child: Text('Item ${index + 1}'),
                        ),
                      )),
            ),
          ),
        );
      });
}
