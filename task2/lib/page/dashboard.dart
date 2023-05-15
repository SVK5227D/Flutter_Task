import 'package:flutter/material.dart';
// import 'package:task2/value/services.dart';
// import 'package:task2/value/userValue.dart';
// import 'package:task2/field.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({super.key});

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  final formKey = GlobalKey<FormState>();
  final taskbar1 = TextEditingController();
  final taskbar2 = TextEditingController();
  final taskbar3 = TextEditingController();

  @override
  void initState() {
    // readValueTable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: DefaultTabController(
          length: 3,
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            child: const TabBar(tabs: [
              Tab(
                child: Text(
                  'Add New task',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Tab(
                child: Text(
                  'Inprocess',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Complete',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              addNewTask();
            },
            child: const Icon(Icons.add)),
      ),
    );
  }

  Future addNewTask() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Add new task'),
            actions: [
              Column(
                children: [
                  Container(
                    width: 600,
                    child: Card(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(14.6),
                      ),
                      elevation: 15,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          prefixIcon: Icon(
                            Icons.add_task,
                            color: Colors.grey,
                          ),
                        ),
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
                          onPressed: () {
                            
                          }, child: const Text('Add')),
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
