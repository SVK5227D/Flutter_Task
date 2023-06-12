import 'package:test1/button.dart';
import 'package:flutter/material.dart';

class CartList extends StatefulWidget {
  final List selectedList;
  const CartList({super.key, required this.selectedList});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List cart = [];
  List laterCard = [];
  callback(value, btnName) {
    if (btnName == 'Save') {
      laterCard.add(value);
      cart.remove(value);
    } else if (btnName == 'MoveCart') {
      cart.add(value);
      laterCard.remove(value);
    } else {
      if (cart.contains(value)) {
        cart.remove(value);
      } else {
        laterCard.remove(value);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    cart = widget.selectedList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Container(
                color: Colors.amber,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin:
                          const EdgeInsets.only(left: 25, right: 25, top: 15),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(cart[index].toString()),
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 50),
                              ),
                              MyButton(
                                btnName: "Save",
                                value: cart[index],
                                callBack: callback,
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              MyButton(
                                btnName: "Delete",
                                value: cart[index],
                                callBack: callback,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: laterCard.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(left: 25, right: 25, top: 15),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(laterCard[index].toString()),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 50),
                            ),
                            MyButton(
                              btnName: "MoveCart",
                              value: laterCard[index],
                              callBack: callback,
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            MyButton(
                              btnName: "Delete",
                              value: laterCard[index],
                              callBack: callback,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
