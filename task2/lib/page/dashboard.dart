import 'package:flutter/material.dart';
import 'package:task2/value/services.dart';
import 'package:task2/value/userValue.dart';
import 'package:task2/tabbar/tabbar_two.dart';
import 'package:task2/tabbar/tabbar_one.dart';
import 'package:task2/tabbar/tabbar_three.dart';
// ignore_for_file: sized_box_for_whitespace

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
  final categoryOne = TextEditingController();
  final categoryTwo = TextEditingController();
  final categoryThree = TextEditingController();
  List<dynamic> _searchTask = [];
  Icon action = const Icon(Icons.search);
  Widget? appTitle;
  int? valueSearch;
  int? searchvalue = 0;

  @override
  void initState() {
    appTitle = Text(widget.user.fullName!);
    readValueTable();
    searchFieldValue(valueSearch);
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

  searchFieldValue(valueSearch) async {
    if (valueSearch == 0) {
      print('Tabbar1 function active');
      var value = await _userServicesList.readAllUsersTask1();
      _searchTask = <TaskValue1>[];
      await value.forEach((userValue) {
        setState(() {
          // var checkId = userValue['id'];
          var userValuelist = TaskValue1();
          userValuelist.userId = userValue['userId'];
          userValuelist.taskId = userValue['taskId'];
          userValuelist.task = userValue['task'];
          if (userValuelist.userId == widget.user.id) {
            _searchTask.add(userValuelist);
          }
        });
      });
      print(_searchTask.length);
    } else if (valueSearch == 1) {
      print('Tabbar2 function active');
      var value = await _userServicesList.readAllUsersTask2();
      _searchTask = <TaskValue2>[];
      await value.forEach((userValue) {
        setState(() {
          // var checkId = userValue['id'];
          var userValuelist = TaskValue2();
          userValuelist.userId = userValue['userId'];
          userValuelist.taskId = userValue['taskId'];
          userValuelist.task = userValue['task'];
          if (userValuelist.userId == widget.user.id) {
            _searchTask.add(userValuelist);
          }
        });
      });
      print(_searchTask.length);
    } else {
      print('Tabbar3 function active');
      var value = await _userServicesList.readAllUsersTask3();
      _searchTask = <TaskValue3>[];
      await value.forEach((userValue) {
        setState(() {
          // var checkId = userValue['id'];
          var userValuelist = TaskValue3();
          userValuelist.userId = userValue['userId'];
          userValuelist.taskId = userValue['taskId'];
          userValuelist.task = userValue['task'];
          if (userValuelist.userId == widget.user.id) {
            _searchTask.add(userValuelist);
          }
        });
      });
      print(_searchTask.length);
    }
  }

  _filter(String valueFind) async {
    print('Onchage called');
    List<dynamic> searchDynamic = [];
    if (valueFind.isEmpty) {
      await searchFieldValue(valueSearch);
      print('if condition called');
      searchDynamic = _searchTask;
    } else {
      searchDynamic = _searchTask
          .where((element) =>
              element.task!.toLowerCase().contains(valueFind.toLowerCase()))
          .toList();
    }
    setState(() {
      _searchTask = searchDynamic;
    });
    print('searchList length ${_searchTask.length}');
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
                      searchContainer();
                      if (this.action.icon == Icons.search) {
                        searchvalue = 1;
                        this.action = const Icon(Icons.close);
                        this.appTitle = TextFormField(
                          onChanged: (value) => _filter(value),
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
                        searchvalue = 0;
                        this.action = const Icon(Icons.search);
                        this.appTitle = Text(widget.user.fullName!);
                      }
                    });
                  },
                  icon: action),
              IconButton(
                  onPressed: () async {
                    // Navigator.pushNamed(context, 'login');
                    await logoutPopUp();
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: searchvalue != 1
              ? Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                        child: TabBar(
                            onTap: (value) async {
                              print('Tabbar value is $value');
                              await searchFieldValue(value);
                              valueSearch = value;
                            },
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
              : searchContainer(),
        ),
      ),
    );
  }

  Widget searchContainer() {
    return ListView.builder(
      itemCount: _searchTask.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 20,
          margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _searchTask[index].task!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future logoutPopUp() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure you want to logout'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, 'login');
              },
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            )
          ],
        ),
      );
}
