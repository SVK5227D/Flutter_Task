import 'package:flutter/material.dart';
import 'package:task2/value/services.dart';
import 'package:task2/value/userValue.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task2/tabbar/tabbar_threeupdate.dart';
// ignore_for_file: use_build_context_synchronously

class TabBarThree extends StatefulWidget {
  final UserInput uservalue;
  const TabBarThree({super.key, required this.uservalue});

  @override
  State<TabBarThree> createState() => _TabBarThreeState();
}

class _TabBarThreeState extends State<TabBarThree> {
  final todoTask3 = TextEditingController();
  List<TaskValue3> _userList = [];
  final _userService = UserService();
  final _userServicesList = UserService();
  addTask() async {
    var user = TaskValue3();
    user.userId = widget.uservalue.id;
    user.task = todoTask3.text;
    await _userService.saveUserTask3(user);
    todoTask3.text = '';
    // await readValueTable();
  }

  readValueTable() async {
    print('read function active');
    var value = await _userServicesList.readAllUsersTask3();
    _userList = <TaskValue3>[];
    value.forEach((userValue) {
      setState(() {
        // var checkId = userValue['id'];
        var userValuelist = TaskValue3();
        userValuelist.userId = userValue['userId'];
        userValuelist.taskId = userValue['taskId'];
        userValuelist.task = userValue['task'];
        if (userValuelist.userId == widget.uservalue.id) {
          _userList.add(userValuelist);
        }
      });
    });
    print(_userList.length);
  }

  @override
  void initState() {
    readValueTable();
    super.initState();
  }

  _deleteValue(userId) async {
    // Navigator.pop(context);
    await _userServicesList.deleteUserTask3(userId);
    await readValueTable();

    Fluttertoast.showToast(
      msg: 'Task removed',
      gravity: ToastGravity.CENTER,
      fontSize: 25,
      backgroundColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _userList.isNotEmpty
          ? ListView.builder(
              itemCount: _userList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 20,
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userList[index].task!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            String refresh = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return UpdateTask3(
                                user: _userList[index],
                              );
                            }));
                            if (refresh == 'closed') {
                              readValueTable();
                            }
                          },
                          icon: const Icon(Icons.edit_document,
                              color: Color.fromRGBO(95, 94, 94, 0.988)),
                        ),
                        IconButton(
                          onPressed: () async {
                            await deletePopUp(_userList[index].taskId!);
                          },
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.next_plan,
                              color: Color.fromRGBO(95, 94, 94, 0.988)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : emptyListPop(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewTask();
        },
        child: const Icon(Icons.add),
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
                        controller: todoTask3,
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
                          onPressed: () async {
                            await addTask();
                            await readValueTable();
                            Navigator.pop(context);
                          },
                          child: const Text('Add')),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            todoTask3.text = '';
                          },
                          child: const Text('Cancel'))
                    ],
                  )
                ],
              ),
            ],
          ));
  Future deletePopUp(id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you want to delete the task'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await _deleteValue(id);
                Navigator.pop(context);
              },
              child: const Text('Ok'),
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

  Widget emptyListPop() {
    return Center(
      child: Container(
        width: 250,
        height: 150,
        color: Colors.redAccent,
        child: const Center(
            child: Text(
          'There is no task',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
