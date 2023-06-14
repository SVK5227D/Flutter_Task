import 'package:flutter/material.dart';
import 'package:ecom/widget/product_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ecom/model/state.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key, required this.value});
  final List value;

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  // @override
  // void initState() {
  //   // _fecthwidget.value();
  //   ref.read(userCart.notifier).addList();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    // final data = ref.watch(userCart);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                crossAxisSpacing: 2.0,
                // mainAxisSpacing: 15,
              ),
              itemCount: widget.value.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
                  elevation: 10,
                  child: GestureDetector(
                    onTap: () {
                      print(widget.value[index].id);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return PlaceDetails(
                            product: widget.value[index],
                          );
                        },
                      ));
                    },
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.value[index].image.length,
                      itemBuilder: (context, imageIndex) {
                        return Image.network(
                          widget.value[index].image[imageIndex],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
