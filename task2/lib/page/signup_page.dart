import '../value/services.dart';
import '../value/userValue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final fullNameController = TextEditingController();
  final emailidController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  List<UserInput> _userList = [];
  final _userServicesList = UserService();
  final formKey = GlobalKey<FormState>();

  readValueTable() async {
    var value = await _userServicesList.readAllUsers();
    _userList = <UserInput>[];
    value.forEach((userValue) {
      setState(() {
        var userValuelist = UserInput();
        userValuelist.fullName = userValue['firstName'];
        userValuelist.emailid = userValue['emailid'];
        userValuelist.mobileNumber = userValue['mobileNumber'];
        userValuelist.password = userValue['mobileNumber'];
        _userList.add(userValuelist);
      });
    });
  }

  @override
  void initState() {
    readValueTable();
    super.initState();
  }

  final _userService = UserService();
  addUser() async {
    await readValueTable();
    var user = UserInput();
    user.fullName = fullNameController.text;
    user.emailid = emailidController.text;
    user.mobileNumber = mobileNumberController.text;
    user.password = passwordController.text;
    await _userService.saveUser(user);
    fullNameController.text = '';
    emailidController.text = '';
    mobileNumberController.text = '';
    passwordController.text = '';
  }

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
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.38),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          controller: fullNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name field is empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          controller: emailidController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: 'Emailid',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Emailid field is empty';
                            } else if (value.isNotEmpty) {
                              for (int i = 0; i < _userList.length; i++) {
                                if (value == _userList[i].emailid) {
                                  return 'EmialId is already exits';
                                }
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          controller: mobileNumberController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: 'Mobile Number',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            prefixIcon: Icon(Icons.phone_android),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Mobile Number field is empty';
                            } else if (value.isNotEmpty) {
                              for (int i = 0; i < _userList.length; i++) {
                                if (value == _userList[i].mobileNumber) {
                                  return 'Mobile Number is already exits';
                                }
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          controller: passwordController,
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
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password field is empty';
                            } else if (value.isNotEmpty) {
                              for (int i = 0; i < _userList.length; i++) {
                                if (value == _userList[i].password) {
                                  return 'Password is already exits';
                                }
                              }
                            } else if (value.length < 8) {
                              return 'Enter more than eight letters';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            addUser();
                          }
                          Navigator.pushNamed(context, 'login');
                        },
                        child: const Text('Signup',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                decoration: TextDecoration.underline)),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.only(left: 55),
                        child: Row(
                          children: [
                            const Text('Already have an account?',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'login');
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
