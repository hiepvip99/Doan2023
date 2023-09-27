import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../product/product_view.dart';

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
          Get.toNamed(ProductView.route);
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
            const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('1250000đ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
