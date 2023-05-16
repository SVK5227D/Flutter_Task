import 'package:flutter/material.dart';
import 'package:task2/value/services.dart';
import 'package:task2/value/userValue.dart';
import 'package:task2/tabbar/tabbar_two.dart';
import 'package:task2/tabbar/tabbar_one.dart';
import 'package:task2/tabbar/tabbar_three.dart';
// ignore_for_file: unnecessary_this

// ignore_for_file: unrelated_type_equality_checks

class UserDashBoard extends StatefulWidget {
  final UserInput user;
  const UserDashBoard({super.key, required this.user});

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  final formKey = GlobalKey<FormState>();
  final todoTask = TextEditingController();
  List<dynamic> tabbarname = [];
  Icon action = const Icon(Icons.search);
  Widget? appTitle;

  @override
  void initState() {
    appTitle = Text(widget.user.fullName!);
    readValueTable();
    super.initState();
  }

  final _userServicesList = UserService();
  List<UserInput> _userList = [];
  readValueTable() async {
    print('read function active');
    var value = await _userServicesList.readAllUsers();
    _userList = <UserInput>[];
    value.forEach((userValue) {
      setState(() {
        var userValuelist = UserInput();
        userValuelist.id = userValue['id'];
        userValuelist.fullName = userValue['fullName'];
        userValuelist.mobileNumber = userValue['mobileNumber'];
        userValuelist.password = userValue['password'];
        _userList.add(userValuelist);
      });
    });

    print(_userList.length);
    print(widget.user.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: appTitle,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (this.action.icon == Icons.search) {
                        this.action = const Icon(Icons.close);
                        this.appTitle = TextFormField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.white),
                              hintText: "Search...",
                              hintStyle: TextStyle(color: Colors.white)),
                        );
                      } else {
                        this.action = const Icon(Icons.search);
                        this.appTitle = Text(widget.user.fullName!);
                      }
                    });
                  },
                  icon: action),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: tabbarname.isNotEmpty
              ? Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: TabBar(
                            indicator: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(25)),
                            // controller: _tabController,
                            tabs: const <Widget>[
                              Tab(
                                child: Text(
                                  'Add New\n task',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Inprocess',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Complete',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ]),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            TabBarOne(uservalue: widget.user),
                            TabBarTwo(uservalue: widget.user),
                            TabBarThree(uservalue: widget.user),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : addTabbarName(),
        ),
      ),
    );
  }

  Widget addTabbarName() {
    return Container(
      child: Column(
        children: [
          Container(
            width: 600,
            child: Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(14.6),
              ),
              elevation: 15,
              child: TextFormField(
                controller: todoTask,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
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
              ElevatedButton(onPressed: () async {}, child: const Text('Add')),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    todoTask.text = '';
                  },
                  child: const Text('Cancel'))
            ],
          )
        ],
      ),
    );
  }
}
