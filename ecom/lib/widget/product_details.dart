import 'package:flutter/material.dart';
import 'package:ecom/model/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
// ignore_for_file: avoid_print
// import 'dart:io';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.product});
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
                          // autoPlayCurve: FlippedCurve(Curve2DSample(BorderSide.strokeAlignCenter, 5)),
                          viewportFraction: 1,
                        ))),
                Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
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
                            ))
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Expanded(
                        child: Card(
                      child: Text(
                        textAlign: TextAlign.center,
                        product.description!,
                        style: const TextStyle(fontSize: 18),
                      ),
                    )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
