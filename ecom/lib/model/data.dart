import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:ecom/model/product.dart';
import 'package:ecom/widget/product_details.dart';
// ignore_for_file: prefer_const_constructors_in_immutables
// ignore_for_file: avoid_print
// ignore_for_file: unused_element
// ignore_for_file: prefer_typing_uninitialized_variables
// ignore_for_file: must_be_immutable

class DataValue extends StatefulWidget {
  DataValue({super.key});
  @override
  State<DataValue> createState() => _DataValueState();
}

class _DataValueState extends State<DataValue> {
  final String? uri = 'https://api.escuelajs.co/api/v1/products';
  var response;
  List dumy = [];
  List productsList = [];
  bool isLoading = false;

  _fecthData() async {
    await InternetAddress.lookup('escuelajs.co');
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse(uri!);
    response = await get(url);
    dumy = await jsonDecode(response.body);
    dumy = dumy.map<Products>((element) => Products.formJson(element)).toList();
    for (var element in dumy) {
      print(element.image.toString());
      productsList.add(element);
    }
    print('******************${productsList.length}*************');
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fecthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scrollbar(
      trackVisibility: true,
      thumbVisibility: true,
      thickness: 15,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          // mainAxisSpacing: 15,
        ),
        itemCount: productsList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(right: 15, left: 15, top: 15),
            elevation: 10,
            child: GestureDetector(
              onTap: () {
                print(productsList[index].id);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return PlaceDetails(
                      product: productsList[index],
                    );
                  },
                ));
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productsList[index].image.length,
                itemBuilder: (context, imageIndex) {
                  return Image.network(productsList[index].image[imageIndex]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
