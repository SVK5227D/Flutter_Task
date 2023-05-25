import '../value/userValue.dart';
import '../services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task2/page/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore_for_file: avoid_function_literals_in_foreach_calls

// ignore_for_file: avoid_print


// ignore_for_file: use_build_context_synchronously

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text Controller
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final changepassword = TextEditingController();
  final changePasswordMobile = TextEditingController();
  List<UserInput> _userList = [];
  final _userServicesList = UserService();
  final formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  int toast = 0;
  // Getting value from user table
  readValueTable() async {
    print('read function active');
    var value = await _userServicesList.readAllUsers();
    _userList = <UserInput>[];
    value.forEach((userValue) {
      setState(() {
        var userValuelist = UserInput();
        userValuelist.id = userValue['id'];
        userValuelist.fullName = userValue['fullName'];
        userValuelist.emailid = userValue['emailid'];
        userValuelist.mobileNumber = userValue['mobileNumber'];
        userValuelist.password = userValue['password'];
        _userList.add(userValuelist);
      });
    });
    print(_userList.length);
  }

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
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              prefixIcon: const Icon(Icons.password),
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
                            ),
                            obscureText: !passwordVisible,
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
                              toast = 0;
                              if (formKey.currentState!.validate()) {
                                for (var element in _userList) {
                                  if (element.mobileNumber ==
                                      mobileNumberController.text) {
                                    if (element.password ==
                                        passwordController.text) {
                                      toast = 0;
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) {
                                          return UserDashBoard(user: element);
                                        },
                                      ));
                                      mobileNumberController.text = '';
                                      passwordController.text = '';
                                    } else {
                                      toast = 1;
                                    }
                                  } else {
                                    toast = 2;
                                  }
                                }
                              }
                              if (toast == 1) {
                                Fluttertoast.showToast(
                                  msg: 'Password is Incorrect',
                                  gravity: ToastGravity.CENTER,
                                  fontSize: 25,
                                  backgroundColor: Colors.red,
                                );
                              }
                              if (toast == 2) {
                                Fluttertoast.showToast(
                                  msg: 'UserName is Incorrect',
                                  gravity: ToastGravity.CENTER,
                                  fontSize: 25,
                                  backgroundColor: Colors.red,
                                );
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
                        TextButton(
                          onPressed: () {
                            resetTask();
                          },
                          child: const Text(
                            'Forgot Password!',
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

  Future resetTask() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Update new Password'),
            actions: [
              Column(
                children: [
                  SizedBox(
                    width: 600,
                    child: Card(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(14.6),
                      ),
                      elevation: 15,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: changePasswordMobile,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: Colors.grey,
                              ),
                              hintText: 'Enter your mobile number',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: changepassword,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.grey,
                                ),
                                hintText: 'Enter your new password'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            print('password changed called');
                            _userList.forEach((element) async {
                              if (element.mobileNumber ==
                                  changePasswordMobile.text) {
                                print('if condition active');
                                var user = UserInput();
                                final userService = UserService();
                                user.id = element.id;
                                user.fullName = element.fullName;
                                user.emailid = element.emailid;
                                user.mobileNumber = element.mobileNumber;
                                user.password = changepassword.text;
                                await userService.updateUser(user);
                                Navigator.pop(context);
                                changePasswordMobile.text = '';
                                changepassword.text = '';
                              }
                            });
                            await readValueTable();
                          },
                          child: const Text('Update')),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'))
                    ],
                  )
                ],
              ),
            ],
          ));
}
