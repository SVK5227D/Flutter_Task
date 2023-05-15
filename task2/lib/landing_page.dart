import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 186, 211, 223)),
        home: Scaffold(
          body: Column(
            children: [
              const Image(image: AssetImage('images/start.png')),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15),
                child: const Text(
                  'Create a task plan\n Before you begin.',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Card(
                elevation: 45,
                color: const Color.fromARGB(255, 53, 64, 81),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 25),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'signup');
                        },
                        child: const Text('Signup',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(25),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child:
                            const Text('Login', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
