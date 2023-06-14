import 'package:flutter/material.dart';
import 'package:ecom/model/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
// ignore_for_file: unrelated_type_equality_checks

// ignore_for_file: avoid_print

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({Key? key, required this.product}) : super(key: key);
  final Products product;

  @override
  Widget build(BuildContext context) {
    print(product.image.length);
    print(product.category);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  height: 250,
                  width: 450,
                  child: CarouselSlider.builder(
                    itemCount: product.image.length,
                    itemBuilder: (context, index, realIndex) {
                      return Image.network(
                        product.image[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      viewportFraction: 1,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: Card(
                          child: Text(
                            'Price : ${product.price.toString()}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Add Cart',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Expanded(
                    child: Card(
                      child: Text(
                        product.description!,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
