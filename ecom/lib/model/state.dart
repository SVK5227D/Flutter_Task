import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ecom/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore_for_file: avoid_print

class AddList extends StateNotifier<List<Products>> {
  AddList() : super(const []);
  final String uri = 'https://svk5227d.github.io/Products-json/productslist.json';
  List dumy = [];

   addList() async {
    var url = Uri.parse(uri);
    var response = await get(url);
    dumy = await jsonDecode(response.body);
    dumy = dumy.map<Products>((element) => Products.formJson(element)).toList();
    for (var element in dumy) {
      print(element.image.toString());
      state = [element, ...state];
    }
    print('******************${dumy.length}*************');
  }
}

final userCart =
    StateNotifierProvider<AddList, List<Products>>((ref) => AddList());
