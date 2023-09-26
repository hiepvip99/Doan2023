import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  ProductCard({super.key});

  final RxBool favorite = false.obs;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.green,
      child: InkWell(
        onTap: () {
          print('object');
        },
        child: Stack(
          children: [
            // const Text('image product'),
            GestureDetector(
                onTap: () {
                  print('product');
                  favorite.value = !favorite.value;
                },
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      favorite.value
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: favorite.value ? Colors.red : Colors.black,
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('1250000đ'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
