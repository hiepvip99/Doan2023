import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant.dart';
import '../../../../../extendsion/extendsion.dart';
import '../../../../../model/network/product_manager_model.dart';
import '../../admin/components/product_manager/product_manager_view.dart';
import '../product/product_view.dart';

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.product});

  final RxBool favorite = false.obs;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      // color: Colors.green,
      child: GestureDetector(
        onTap: () {
          print('object');
          Get.toNamed(ProductView.route, arguments: product);
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ImageComponent(
                      isShowBorder: false,
                      imageUrl: product.colors?.length != 0
                          ? product.colors?.first.images?.length != 0
                              ? domain +
                                  (product.colors?.first.images?.first.url ??
                                      '')
                              : ''
                          : ''),
                ),
                SizedBox(
                  height: 44,
                )
              ],
            ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(product.name ?? '', overflow: TextOverflow.ellipsis),
                    Text(product.colors?.length != 0
                        ? formatMoney(product.colors?.first.price ?? 0)
                        : '0 đ'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
