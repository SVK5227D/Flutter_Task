import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/register.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 150, left: 45),
              child: const Text(
                'Signup',
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.38),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: 'Emailid',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          prefixIcon: Icon(Icons.phone_android),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
