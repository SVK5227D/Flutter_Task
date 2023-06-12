import 'package:test1/cart.dart';
import 'package:flutter/material.dart';

// Widget
class ListItem extends StatefulWidget {
  const ListItem({super.key});

  @override
  State<ListItem> createState() => _ListItemState();
}

// State of the Widget
class _ListItemState extends State<ListItem> {
  List value = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
  ];
  List selectedList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CartList(selectedList: selectedList);
                      },
                    ),
                  ).then((value) => setState(
                        () {},
                      ));
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                  size: 32,
                ))
          ],
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            value.length,
            (index) => TextButton(
              onPressed: () {
                setState(() {
                  if (selectedList.contains(value[index].toString())) {
                    selectedList.remove(value[index].toString());
                  } else {
                    selectedList.add(value[index].toString());
                  }
                });
                print(selectedList.toString());
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 15,
                color: selectedList.contains(value[index].toString())
                    ? Colors.green
                    : null,
                shadowColor: selectedList.contains(value[index].toString())
                    ? Colors.purple
                    : null,
                child: Center(
                  child: Text(
                    value[index],
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
