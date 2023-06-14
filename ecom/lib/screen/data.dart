import 'package:ecom/model/state.dart';
import 'package:flutter/material.dart';
import 'package:ecom/widget/product_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore_for_file: prefer_const_constructors_in_immutables
// ignore_for_file: avoid_print
// ignore_for_file: unused_element
// ignore_for_file: prefer_typing_uninitialized_variables
// ignore_for_file: must_be_immutable

class DataValue extends ConsumerStatefulWidget {
  const DataValue({super.key});
  @override
  ConsumerState<DataValue> createState() => _DataValueState();
}

class _DataValueState extends ConsumerState<DataValue> {
  @override
  void initState() {
    // _fecthData();
    ref.read(userCart.notifier).addList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userCart);
    return Scrollbar(
      trackVisibility: true,
      thumbVisibility: true,
      thickness: 15,
      child: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              // mainAxisSpacing: 15,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    print(data[index].id);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return PlaceDetails(
                          product: data[index],
                        );
                      },
                    ));
                  },
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data[index].image.length,
                    itemBuilder: (context, imageIndex) {
                      return Image.network(
                        data[index].image[imageIndex],
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
// CarouselSlider.builder(
//                         itemCount: data[index].image.length,
//                         itemBuilder: (context, imageIndex, realIndex) {
//                           return Image.network(data[index].image[imageIndex]);
//                         },
//                         options: CarouselOptions(
//                           autoPlay: true,
//                           enableInfiniteScroll: true,
//                           viewportFraction: 1,
//                         ),
//                       ),