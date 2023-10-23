// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/textfield_common.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';

import '../../../../../constant.dart';
import '../../../../../extendsion/extendsion.dart';
import '../../admin/components/product_manager/product_manager_view.dart';
import '../order/order_view.dart';
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
                    initSelected: viewModel.productSelected.any((element) =>
                        viewModel.productInCart[index].productInCart.id ==
                        element.productInCart.id),
                    onCheckChange: (isChecked) {
                      if (isChecked) {
                        viewModel.productSelected.addIf(
                            !viewModel.productSelected.any((element) =>
                                viewModel
                                    .productInCart[index].productInCart.id ==
                                element.productInCart.id),
                            viewModel.productInCart[index]);
                      } else {
                        viewModel.productSelected.removeWhere((element) =>
                            viewModel.productInCart[index].productInCart.id ==
                            element.productInCart.id);
                      }
                    },
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
                child: Obx(() =>
                    Text(
                    'Tổng thanh toán: ${formatMoney(viewModel.getTotalPrice())}'))),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
              onPressed: () {
                if (viewModel.productSelected.value.isNotEmpty) {
                  Get.toNamed(OrderView.route,
                      arguments: viewModel.productSelected.value);
                } else {
                  DialogCommon().showAlertDialog(
                      context: context, title: 'Bạn chưa chọn sản phẩm nào');
                }
              },
              child: const Text('Mua hàng'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCartItem extends StatefulWidget {
  const ProductCartItem({
    super.key,
    required this.productCartModel,
    required this.colorName,
    required this.sizeName,
    required this.onChangeQuantity,
    required this.updateQuantityNoRefesh,
    required this.onCheckChange,
    required this.initSelected,
  });
  final bool initSelected;
  final ProductCartModel productCartModel;
  final String colorName;
  final String sizeName;
  final Function(int quantity) onChangeQuantity;
  final Function(int quantity) updateQuantityNoRefesh;
  final Function(bool isChecked) onCheckChange;

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  final RxBool isSelected = false.obs;

  @override
  void initState() {
    super.initState();
    isSelected.value = widget.initSelected;
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
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
                          (widget.productCartModel.productInCart.images
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
                  child: Stack(
                    children: [
                      FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8),
                              child: Text(
                                widget.productCartModel.productInCart.name ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8),
                              child: Text(
                                'Phân loại: ${widget.colorName} || ${widget.sizeName}',
                                overflow: TextOverflow.ellipsis,
                                // style: TextStyle(fontSize: 14),
                              ),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8),
                              child: Text(
                                  'Giá: ${formatMoney(widget.productCartModel.productInCart.price ?? 0)}'),
                            ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          widget.onChangeQuantity((widget
                                                      .productCartModel
                                                      .productInCart
                                                      .quantity ??
                                                  0) -
                                              1);
                                          // if ((productCartModel
                                          //             .productInCart.quantity ??
                                          //         0) >
                                          //     1) {

                                          // }
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
                                                (widget
                                                        .productCartModel
                                                        .productInCart
                                                        .inventoryQuantity ??
                                                    1)) {
                                              widget.onChangeQuantity(widget
                                                      .productCartModel
                                                      .productInCart
                                                      .inventoryQuantity ??
                                                  1);
                                              DialogCommon()
                                                  .showAlertDialog(
                                                      context: context,
                                                      title:
                                                          'Bạn đã chọn quá số lượng sản phẩm trong kho');
                                            } else {
                                              widget.updateQuantityNoRefesh(
                                                  count);
                                            }
                                          },
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          controller: TextEditingController(
                                              text: widget.productCartModel
                                                  .productInCart.quantity
                                                  ?.toString()),
                                        ),
                                      ),
                                      // Text(
                                      //     '${productCartModel.productInCart.quantity ?? 0}'),
                                      ElevatedButton(
                                          onPressed: () {
                                            if ((widget
                                                        .productCartModel
                                                        .productInCart
                                                        .inventoryQuantity ??
                                                    99) >
                                                (widget
                                                        .productCartModel
                                                        .productInCart
                                                        .quantity ??
                                                    0)) {
                                              widget.onChangeQuantity((widget
                                                          .productCartModel
                                                          .productInCart
                                                          .quantity ??
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
                                    'Kho ${widget.productCartModel.productInCart.inventoryQuantity?.toString() ?? ''}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                              height: 24,
                              width: 24,
                              child: Obx(
                                () => Checkbox(
                                  value: isSelected.value,
                                  onChanged: (value) {
                                    isSelected.value = !isSelected.value;
                                    widget.onCheckChange(isSelected.value);
                                  },
                                ),
                              )),
                        ],
                      )
                    ],
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
