import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  final urlController = TextEditingController();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  add() {}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              controller: urlController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter the url',
                  prefixIcon: Icon(Icons.link)),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the Title',
                prefixIcon: Icon(Icons.title_outlined),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter the Description',
                  prefixIcon: Icon(Icons.description)),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(onPressed: add, child: const Text('Add'))
          ],
        )),
      ),
    ));
  }
}
