import 'package:task/map_value.dart';
import '../../services/inputpass.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore_for_file: use_build_context_synchronously

class UpdateValue extends StatefulWidget {
  final UserInput user;
  const UpdateValue({
    super.key,
    required this.user,
  });

  @override
  State<UpdateValue> createState() => _UpdateValue();
}

class _UpdateValue extends State<UpdateValue> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailidController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final percentageController = TextEditingController();
  final _userService = UserService();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    firstNameController.text = widget.user.firstName ?? '';
    lastNameController.text = widget.user.lastName ?? '';
    emailidController.text = widget.user.emailid ?? '';
    mobileNumberController.text = widget.user.mobileNumber ?? '';
    percentageController.text = widget.user.percentage.toString();
    super.initState();
  }

  update() async {
    print('Update id active');
    print(widget.user.id);
    var user = UserInput();
    user.id = widget.user.id;
    user.firstName = firstNameController.text;
    user.lastName = lastNameController.text;
    user.emailid = emailidController.text;
    user.mobileNumber = mobileNumberController.text;
    user.percentage = double.parse(percentageController.text);
    await _userService.UpdateUser(user);
    Navigator.pop(context, 'closed');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('InputField'), centerTitle: true),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      prefixIcon: Icon(Icons.person),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is empty";
                      } else {
                        return null;
                      }
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
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      prefixIcon: Icon(Icons.person_rounded),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is empty";
                      } else {
                        return null;
                      }
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
                    } else {
                      return null;
                    }
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
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 10,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is empty";
                      } else {
                        return null;
                      }
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
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                padding: const EdgeInsets.only(top: 20, left: 45, right: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          update();
                        }
                      },
                      child: const Text('Update'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'notReload');
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
