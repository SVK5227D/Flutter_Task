import '../value/services.dart';
import '../value/userValue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore_for_file: use_build_context_synchronously

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  List<UserInput> _userList = [];
  final _userServicesList = UserService();
  final formKey = GlobalKey<FormState>();
  var userCount = 0;

  readValueTable() async {
    print('read function active');
    var value = await _userServicesList.readAllUsers();
    _userList = <UserInput>[];
    value.forEach((userValue) {
      setState(() {
        var userValuelist = UserInput();
        userValuelist.id = userValue['id'];
        userValuelist.mobileNumber = userValue['mobileNumber'];
        userValuelist.password = userValue['password'];
        userValuelist.userCount = userValue['userCount'];
        _userList.add(userValuelist);
      });

      print(_userList.length);
    });
  }
  // addCount(i) async {
  //   var user = UserInput();
  //   user.userCount = _userList[i].userCount;
  //   await _userService.saveUser(user);
  // }

  @override
  void initState() {
    readValueTable();
    super.initState();
  }

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
                margin: const EdgeInsets.only(top: 150, left: 65),
                child: const Text(
                  'Welcome\nBack',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.45),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
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
                              prefixIcon: Icon(Icons.phone),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Mobile Number field is empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () async {
                              // Navigator.pushNamed(context, 'checkData');
                              for (int i = 0; i < _userList.length; i++) {
                                print(_userList[i].toMap());
                                if (_userList[i].mobileNumber ==
                                    mobileNumberController.text) {
                                  if (_userList[i].password ==
                                      passwordController.text) {
                                    Navigator.pushNamed(
                                      context,
                                      'checkData',
                                    );
                                  } else {
                                    print('not true');
                                  }
                                }
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 24,
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
                ),
              )
            ],
          )),
    );
  }
}
