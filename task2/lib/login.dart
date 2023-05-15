import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 175, left: 55),
                child: const Text(
                  'Welcome\nBack',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.45),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: 'Mobile Number',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            prefixIcon: Icon(Icons.password),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'signup');
                        },
                        child: const Text(
                          'SignUp',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
