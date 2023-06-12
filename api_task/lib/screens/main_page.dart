import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:api_task/model/sample.dart';
import 'package:api_task/screens/data_list.dart';
// ignore_for_file: use_build_context_synchronously
// ignore_for_file: avoid_print

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  String? _error;
  List dumy = [];
  List todosList = [];
  List userIdList = [];
  int? filterId;
  dynamic response;
  final uri = "https://jsonplaceholder.typicode.com/todos";
  valueGet() async {
    setState(() {
      isLoading = true;
    });
    // Getting value from url
    try {
      await InternetAddress.lookup('typicode.com');
      var url = Uri.parse(uri);
      response = await get(url);
      // The response value can be encode
      print('*************   HTTP   *************');
      print("Response url ${response.statusCode}");
      if (response.statusCode >= 400) {
        _error = 'Failed to get the data. Please try again';
        setState(() {
          isLoading = false;
        });
      } else {
        dumy = jsonDecode(response.body);
        dumy = dumy.map<Todos>((e) => Todos.formJson(e)).toList();
        await listValue(filterId = null);
      }
    } on SocketException catch (err) {
      print(err);
      setState(() {
        isLoading = false;
      });
      _error = 'Check youe internet connection';
    }
    _getUserid();
  }

  @override
  void initState() {
    valueGet();
    super.initState();
  }

  listValue(filterId) async {
    print('***************** $filterId ***********************');
    if (filterId == null) {
      todosList = dumy;
    } else {
      todosList = [];
      for (var element in dumy) {
        print(element.userId);
        if (element.userId == filterId) {
          todosList.add(element);
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  _getUserid() {
    for (var element in todosList) {
      print(element.userId);
      if (userIdList.contains(element.userId)) {
      } else {
        userIdList.add(element.userId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                filterList();
              },
              icon: const Icon(Icons.filter_list),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  todosList = dumy;
                });
              },
              icon: const Icon(Icons.clear),
            ),
          ]),
      body:
          // Listing the json value
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _error != null
                  ? Center(
                      child: Text(
                        _error!,
                        style: const TextStyle(fontSize: 18),
                      ),
                    )
                  : todosList.isEmpty
                      ? const Center(
                          child: Text('No todo in List'),
                        )
                      : Scrollbar(
                          interactive: Platform.isAndroid,
                          thumbVisibility: true,
                          thickness: 18,
                          child: DataList(
                            values: todosList,
                          ),
                        ),
    );
  }

  Future filterList() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Filter using UserId'),
          content: SizedBox(
            width: 100,
            height: 250,
            child: ListView.builder(
              itemCount: userIdList.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () async {
                    filterId = null;
                    filterId = index + 1;
                    await listValue(userIdList[index]);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    userIdList[index].toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
          ),
        ),
      );
}
