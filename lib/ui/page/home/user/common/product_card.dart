import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant.dart';
import '../../../../../extendsion/extendsion.dart';
import '../../../../../model/network/product_manager_model.dart';
import '../../admin/components/product_manager/product_manager_view.dart';
import '../product/product_view.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    super.key,
    required this.product,
    this.isShowChecked = false,
    this.onRefesh,
    this.onSelected,
  });

  // final RxBool favorite = false.obs;
  final Product product;
  final bool isShowChecked;
  final RxBool isChecked = false.obs;

  final Function()? onRefesh;
  final Function(Favorite favorite, bool isChecked)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      // color: Colors.grey.shade300,
      child: InkWell(
        onTap: () {
          print('object');
          isShowChecked
              ? isChecked.value = !isChecked.value
              : Get.toNamed(ProductView.route, arguments: product)
                  ?.whenComplete(() => onRefesh != null ? onRefesh!() : null);
          if (onSelected != null) {
            onSelected!(Favorite(productId: product.id), isChecked.value);
          }
        },
        child: Obx(
          () => Container(
            color: isChecked.value ? Colors.blue.shade200 : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ImageComponent(
                                  isShowBorder: false,
                                  imageUrl: product.colors?.length != 0
                                      ? product.colors?.first.images?.length !=
                                              0
                                          ? domain +
                                              (product.colors?.first.images
                                                      ?.first.url ??
                                                  '')
                                          : ''
                                      : ''),
                            ),
                          ),
                          const SizedBox(
                            height: 44,
                          )
                        ],
                      ),
                      // const Text('image product'),
                      // GestureDetector(
                      //     onTap: () {
                      //       print('product');
                      //       favorite.value = !favorite.value;
                      //     },
                      //     child: Obx(
                      //       () => Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Icon(
                      //           favorite.value
                      //               ? Icons.favorite
                      //               : Icons.favorite_border_outlined,
                      //           color: favorite.value ? Colors.red : Colors.black,
                      //         ),
                      //       ),
                      //     )),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(product.name ?? '',
                                  overflow: TextOverflow.ellipsis),
                              Text(product.colors?.length != 0
                                  ? formatMoney(
                                      product.colors?.first.price ?? 0)
                                  : '0 đ'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: isShowChecked,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Obx(
                          () => Checkbox(
                            value: isChecked.value,
                            onChanged: null,
                            checkColor: Colors.white,
                            fillColor:
                                const MaterialStatePropertyAll(Colors.blue),
                            // fillColor: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
