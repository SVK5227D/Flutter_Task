import 'package:flutter/material.dart';
import 'package:task2/value/userValue.dart';
import 'package:task2/services/services.dart';
// ignore_for_file: use_build_context_synchronously


class UpdateTask extends StatefulWidget {
  final TaskValue1 user;
  const UpdateTask({super.key, required this.user});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final taskValue = TextEditingController();

  final _userService = UserService();
  @override
  void initState() {
    taskValue.text = widget.user.task!;
    super.initState();
  }

  update() async {
    var user = TaskValue1();
    user.userId = widget.user.userId;
    user.taskId= widget.user.taskId;
    user.task = taskValue.text;
    await _userService.updateUserTask1(user);
    Navigator.pop(context,'closed');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update task'),
      content: TextFormField(
        controller: taskValue,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          prefixIcon: Icon(
            Icons.update,
            color: Colors.grey,
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            update();
          },
          child: const Text('Update'),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context,'cancel');
          },
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
