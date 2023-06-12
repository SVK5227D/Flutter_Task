import 'package:flutter/material.dart';
// ignore_for_file: avoid_print
// ignore_for_file: unused_element

class DataList extends StatefulWidget {
  const DataList({super.key, required this.values});
  final List values;

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  TextEditingController todosTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void checkBox(bool? value, int index) {
      setState(() {
        widget.values[index].checkBox = !widget.values[index].checkBox!;
      });
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.values.length,
      itemBuilder: (context, index) {
        return Flexible(
          child: Card(
            margin:
                const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
            elevation: 20,
            child: ListTile(
              title: Row(
                children: [
                  Checkbox(
                    activeColor: Colors.red,
                    value: widget.values[index].checkBox!,
                    onChanged: (value) => checkBox(value, index),
                  ),
                  Expanded(
                    child: Text(
                      'Task : ${widget.values[index].todo!}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      editValue(index);
                      setState(() {
                        todosTitleController.text = widget.values[index].todo;
                      });
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      deletePopUp(index);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future deletePopUp(id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you want to delete the value'),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.values.removeAt(id);
                });
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

  Future editValue(index) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Update task'),
          content: TextFormField(
            controller: todosTitleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              prefixIcon: Icon(
                Icons.update,
                color: Colors.grey,
              ),
            ),
            maxLines: 5,
            minLines: 1,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.values[index].todo = todosTitleController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context, 'cancel');
              },
              child: const Text('Cancel'),
            )
          ],
        ),
      );
}
