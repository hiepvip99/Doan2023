// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/textfield_common.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';

import '../../../../../constant.dart';
import '../../../../../extendsion/extendsion.dart';
import '../../admin/components/product_manager/product_manager_view.dart';
import 'cart_view_model.dart';

class ShoppingCartScreen extends StatelessWidget {
  static const route = '/ShoppingCartScreen';

  ShoppingCartScreen({super.key});

  final viewModel = Get.find<CartViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: viewModel.productInCart.value.length,
                itemBuilder: (context, index) {
                  return ProductCartItem(
                    onChangeQuantity: (quantity) =>
                        viewModel.updateQuantity(index, quantity),
                    updateQuantityNoRefesh: (quantity) =>
                        viewModel.updateQuantityNoRefesh(index, quantity),
                    sizeName: viewModel.getSizeName(viewModel
                        .productInCart.value[index].productInCart.sizeId),
                    colorName: viewModel.getColorName(viewModel
                        .productInCart.value[index].productInCart.colorId),
                    productCartModel: viewModel.productInCart.value[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}

class ProductCartItem extends StatelessWidget {
  const ProductCartItem({
    super.key,
    required this.productCartModel,
    required this.colorName,
    required this.sizeName,
    required this.onChangeQuantity,
    required this.updateQuantityNoRefesh,
  });

  final ProductCartModel productCartModel;
  final String colorName;
  final String sizeName;
  final Function(int quantity) onChangeQuantity;
  final Function(int quantity) updateQuantityNoRefesh;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: width * 0.3,
                  width: width * 0.3,
                  child: ImageComponent(
                      isShowBorder: false,
                      imageUrl: domain +
                          (productCartModel.productInCart.images
                                  ?.firstWhereOrNull(
                                      (element) => element.url != null)
                                  ?.url ??
                              '')),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: width * 0.6,
                  child: FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                          child: Text(
                            productCartModel.productInCart.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                          child: Text(
                            'Phân loại: $colorName || $sizeName',
                            overflow: TextOverflow.ellipsis,
                            // style: TextStyle(fontSize: 14),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                          child: Text(
                              'Giá: ${formatMoney(productCartModel.productInCart.price ?? 0)}'),
                        ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if ((productCartModel
                                                  .productInCart.quantity ??
                                              0) >
                                          1) {
                                        onChangeQuantity((productCartModel
                                                    .productInCart.quantity ??
                                                0) -
                                            1);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder()),
                                    child: const Text('-'),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: TextFieldCommon(
                                      onChanged: (value) {
                                        final count = int.parse(value);
                                        if (count >
                                            (productCartModel.productInCart
                                                    .inventoryQuantity ??
                                                1)) {
                                          onChangeQuantity(productCartModel
                                                  .productInCart
                                                  .inventoryQuantity ??
                                              1);
                                          Get.find<DialogCommon>().showAlertDialog(
                                              context: context,
                                              title:
                                                  'Bạn đã chọn quá số lượng sản phẩm trong kho');
                                        } else {
                                          updateQuantityNoRefesh(count);
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      controller: TextEditingController(
                                          text: productCartModel
                                              .productInCart.quantity
                                              ?.toString()),
                                    ),
                                  ),
                                  // Text(
                                  //     '${productCartModel.productInCart.quantity ?? 0}'),
                                  ElevatedButton(
                                      onPressed: () {
                                        if ((productCartModel.productInCart
                                                    .inventoryQuantity ??
                                                99) >
                                            (productCartModel
                                                    .productInCart.quantity ??
                                                0)) {
                                          onChangeQuantity((productCartModel
                                                      .productInCart.quantity ??
                                                  0) +
                                              1);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder()),
                                      child: const Text('+')),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                                'Kho ${productCartModel.productInCart.inventoryQuantity?.toString() ?? ''}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Divider(
            //   thickness: 8,
            // )
          ],
        ),
      ),
    );
  }
}
