import 'package:flutter/material.dart';

class CartList extends StatefulWidget {
  final List selectedList;
  const CartList({super.key, required this.selectedList});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: widget.selectedList.length,
          itemBuilder: (context, index) {
            return Card(
              // child: Center(
              //   child: Text(
              //     widget.selectedList[index],
              //     style: const TextStyle(
              //       fontSize: 25,
              //     ),
              //   ),
              // ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.selectedList[index].toString()),
                  ),
                  ButtonBar(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.movie_filter)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
