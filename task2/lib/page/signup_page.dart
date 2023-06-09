import '../value/userValue.dart';
import '../services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore_for_file: use_build_context_synchronously


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Text Controller
  final fullNameController = TextEditingController();
  final emailidController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  List<UserInput> _userList = [];
  final _userServicesList = UserService();
  final formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  readValueTable() async {
    var value = await _userServicesList.readAllUsers();
    _userList = <UserInput>[];
    value.forEach((userValue) {
      setState(() {
        var userValuelist = UserInput();
        userValuelist.fullName = userValue['firstName'];
        userValuelist.emailid = userValue['emailid'];
        userValuelist.mobileNumber = userValue['mobileNumber'];
        userValuelist.password = userValue['password'];
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 200, left: 45),
                child: const Text(
                  'Signup',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
              Container(
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
                            } else if (!RegExp(r'\S+@\S+\.\S+')
                                .hasMatch(value)) {
                              return "Invalid emailid formate";
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
                          maxLength: 10,
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
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            prefixIcon: const Icon(Icons.password),
                          ),
                          obscureText: !passwordVisible,
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
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await addUser();
                            Navigator.pushNamed(context, 'login');
                          }
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
            ],
          ),
        ),
      ),
    );
  }
}
