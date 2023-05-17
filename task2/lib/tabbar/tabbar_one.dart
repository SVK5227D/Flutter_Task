import 'package:flutter/material.dart';
import 'package:task2/value/services.dart';
import 'package:task2/value/userValue.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task2/tabbar/tabbar_oneupdate.dart';
// ignore_for_file: use_build_context_synchronously

class TabBarOne extends StatefulWidget {
  final UserInput uservalue;
  const TabBarOne({super.key, required this.uservalue});

  @override
  State<TabBarOne> createState() => _TabBarOneState();
}

class _TabBarOneState extends State<TabBarOne> {
  final todoTask = TextEditingController();
  List<TaskValue1> _userList = [];
  final _userService = UserService();
  final _userServicesList = UserService();
  addTask() async {
    var user = TaskValue1();
    user.userId = widget.uservalue.id;
    user.task = todoTask.text;
    await _userService.saveUserTask1(user);
    todoTask.text = '';
    // await readValueTable();
  }

  readValueTable() async {
    print('read function active');
    var value = await _userServicesList.readAllUsersTask1();
    _userList = <TaskValue1>[];
    value.forEach((userValue) {
      setState(() {
        // var checkId = userValue['id'];
        var userValuelist = TaskValue1();
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
    await _userServicesList.deleteUserTask1(userId);
    await readValueTable();
    Fluttertoast.showToast(
      msg: 'Task removed',
      gravity: ToastGravity.CENTER,
      fontSize: 25,
      backgroundColor: Colors.red,
    );
  }

  _moveValue(userId) async {
    // Navigator.pop(context);
    await _userServicesList.deleteUserTask1(userId);
    await readValueTable();
    Fluttertoast.showToast(
      msg: 'Task moved to your selected category',
      gravity: ToastGravity.CENTER,
      fontSize: 25,
      backgroundColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 94, 93, 93),
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
                              return UpdateTask(
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
                          onPressed: () async {
                            await movePopUp(_userList[index].taskId!,
                                _userList[index].task!);
                          },
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
        child: const Icon(Icons.add_task),
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
                        controller: todoTask,
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
                            todoTask.text = '';
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

  Future movePopUp(id, task) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you want to move the task'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await choosePopUp(id, task);
              },
              child: const Text('Yes'),
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

  Future choosePopUp(id, task) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Select which category you want to move'),
          actions: [
            Column(
              children: [
                TextButton(
                  onPressed: () async {
                    var user = TaskValue2();
                    user.userId = widget.uservalue.id;
                    user.task = task;
                    await _userService.saveUserTask2(user);
                    await _moveValue(id);
                    Navigator.pop(context);
                  },
                  child: const Text('Inprocess'),
                ),
                TextButton(
                  onPressed: () async {
                    var user = TaskValue3();
                    user.userId = widget.uservalue.id;
                    user.task = task;
                    await _userService.saveUserTask3(user);
                    await _moveValue(id);
                    Navigator.pop(context);
                  },
                  child: const Text('Complete'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                )
              ],
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
