import '../Screen/table.dart';
import '../Screen/listData.dart';
import '../services/inputpass.dart';
import 'package:task/map_value.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore_for_file: use_build_context_synchronously

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputField();
}

class _InputField extends State<InputField> {
  List<UserInput> _userList = [];
  final _userServicesList = UserService();
  final formKey = GlobalKey<FormState>();

  readValueTable() async {
    var value = await _userServicesList.readAllUsers();
    _userList = <UserInput>[];
    value.forEach((userValue) {
      setState(() {
        var userValuelist = UserInput();
        userValuelist.firstName = userValue['firstName'];
        userValuelist.lastName = userValue['lastName'];
        userValuelist.emailid = userValue['emailid'];
        userValuelist.mobileNumber = userValue['mobileNumber'];
        userValuelist.percentage = userValue['percentage'];
        _userList.add(userValuelist);
      });
    });
    print('input field list length check');
    print(_userList.toList());
  }

  @override
  void initState() {
    readValueTable();
    super.initState();
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailidController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final percentageController = TextEditingController();
  final _userService = UserService();

  addTask() async {
    await readValueTable();
    var user = UserInput();
    user.firstName = firstNameController.text;
    user.lastName = lastNameController.text;
    user.emailid = emailidController.text;
    user.mobileNumber = mobileNumberController.text;
    user.percentage = double.parse(percentageController.text);
    await _userService.SaveUser(user);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const ListMapValues();
    }));
    firstNameController.text = '';
    lastNameController.text = '';
    emailidController.text = '';
    mobileNumberController.text = '';
    percentageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('InputField'), centerTitle: true),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 45, top: 30, right: 45),
                  child: TextFormField(
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: 'FirstName',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        prefixIcon: Icon(Icons.person),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is empty";
                        } else if (value.isNotEmpty) {
                          for (int i = 0; i < _userList.length; i++) {
                            if (_userList[i]
                                .firstName!
                                .toLowerCase()
                                .contains(value)) {
                              return "This first name already exits";
                            }
                          }
                        }
                        return null;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 45, top: 10, right: 45),
                  child: TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: 'LastName',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        prefixIcon: Icon(Icons.person_rounded),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is empty";
                        } else if (value.isNotEmpty) {
                          for (int i = 0; i < _userList.length; i++) {
                            if (_userList[i]
                                .lastName!
                                .toLowerCase()
                                .contains(value)) {
                              return "This last name already exits";
                            }
                          }
                        }
                        return null;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 45, top: 10, right: 45),
                  child: TextFormField(
                    controller: emailidController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      labelText: 'Emailid',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is empty";
                      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Invalid emailid formate";
                      } else if (value.isNotEmpty) {
                        for (int i = 0; i < _userList.length; i++) {
                          if (_userList[i]
                              .emailid!
                              .toLowerCase()
                              .contains(value)) {
                            return "This emailid already exits";
                          }
                        }
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 45, top: 10, right: 45),
                  child: TextFormField(
                      controller: mobileNumberController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: 'MobileNumber',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is empty";
                        } else if (value.isNotEmpty) {
                          for (int i = 0; i < _userList.length; i++) {
                            if (_userList[i]
                                .mobileNumber!
                                .toLowerCase()
                                .contains(value)) {
                              return "This mobile number already exits";
                            }
                          }
                        }
                        return null;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 45, top: 10, right: 45),
                  child: TextFormField(
                      controller: percentageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: 'Percentage',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        prefixIcon: Icon(Icons.percent),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is empty";
                        } else {
                          return null;
                        }
                      }),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            addTask();
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const ListMapValues();
                            },
                          ));
                        },
                        child: const Text('View Value'),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const ViewTable();
                            },
                          ));
                        },
                        child: const Text('View table'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
