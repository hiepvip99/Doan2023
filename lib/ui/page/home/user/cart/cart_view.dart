// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      backgroundColor: const Color(0xffF5F5F5),
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
                    showDel: () => viewModel.showDel(index),
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
                child: Obx(() => Text(
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
    required this.showDel,
  });
  final bool initSelected;
  final ProductCartModel productCartModel;
  final String colorName;
  final String sizeName;
  final Function(int quantity) onChangeQuantity;
  final Function() showDel;
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
    // final width = MediaQuery.of(context).size.width;
    // return Container(
    //   margin: const EdgeInsets.only(bottom: 8),
    //   decoration:
    //       BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       children: [
    //         Row(
    //           children: [
    //             SizedBox(
    //               height: width * 0.3,
    //               width: width * 0.3,
    //               child: ImageComponent(
    //                   isShowBorder: false,
    //                   imageUrl: domain +
    //                       (widget.productCartModel.productInCart.images
    //                               ?.firstWhereOrNull(
    //                                   (element) => element.url != null)
    //                               ?.url ??
    //                           '')),
    //             ),
    //             const SizedBox(
    //               width: 8,
    //             ),
    //             SizedBox(
    //               width: width * 0.6,
    //               child: Stack(
    //                 children: [
    //                   FittedBox(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Padding(
    //                           padding:
    //                               const EdgeInsets.only(left: 8.0, bottom: 8),
    //                           child: Text(
    //                             widget.productCartModel.productInCart.name ??
    //                                 '',
    //                             overflow: TextOverflow.ellipsis,
    //                             style: const TextStyle(fontSize: 16),
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding:
    //                               const EdgeInsets.only(left: 8.0, bottom: 8),
    //                           child: Text(
    //                             'Phân loại: ${widget.colorName} || ${widget.sizeName}',
    //                             overflow: TextOverflow.ellipsis,
    //                             // style: TextStyle(fontSize: 14),
    //                           ),
    //                         ),

    //                         Padding(
    //                           padding:
    //                               const EdgeInsets.only(left: 8.0, bottom: 8),
    //                           child: Text(
    //                               'Giá: ${formatMoney(widget.productCartModel.productInCart.price ?? 0)}'),
    //                         ),
    //                         // SizedBox(
    //                         //   height: 8,
    //                         // ),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Container(
    //                               decoration: BoxDecoration(
    //                                   border: Border.all(
    //                                       color: Colors.grey.shade300)),
    //                               child: Row(
    //                                 mainAxisSize: MainAxisSize.min,
    //                                 children: [
    //                                   ElevatedButton(
    //                                     onPressed: () {
    //                                       widget.onChangeQuantity((widget
    //                                                   .productCartModel
    //                                                   .productInCart
    //                                                   .quantity ??
    //                                               0) -
    //                                           1);
    //                                       // if ((productCartModel
    //                                       //             .productInCart.quantity ??
    //                                       //         0) >
    //                                       //     1) {

    //                                       // }
    //                                     },
    //                                     style: ElevatedButton.styleFrom(
    //                                         shape: const CircleBorder()),
    //                                     child: const Text('-'),
    //                                   ),
    //                                   SizedBox(
    //                                     width: 50,
    //                                     child: TextFieldCommon(
    //                                       onChanged: (value) {
    //                                         final count = int.parse(value);
    //                                         if (count >
    //                                             (widget
    //                                                     .productCartModel
    //                                                     .productInCart
    //                                                     .inventoryQuantity ??
    //                                                 1)) {
    //                                           widget.onChangeQuantity(widget
    //                                                   .productCartModel
    //                                                   .productInCart
    //                                                   .inventoryQuantity ??
    //                                               1);
    //                                           DialogCommon()
    //                                               .showAlertDialog(
    //                                                   context: context,
    //                                                   title:
    //                                                       'Bạn đã chọn quá số lượng sản phẩm trong kho');
    //                                         } else {
    //                                           widget.updateQuantityNoRefesh(
    //                                               count);
    //                                         }
    //                                       },
    //                                       keyboardType: TextInputType.number,
    //                                       inputFormatters: [
    //                                         FilteringTextInputFormatter
    //                                             .digitsOnly
    //                                       ],
    //                                       controller: TextEditingController(
    //                                           text: widget.productCartModel
    //                                               .productInCart.quantity
    //                                               ?.toString()),
    //                                     ),
    //                                   ),
    //                                   // Text(
    //                                   //     '${productCartModel.productInCart.quantity ?? 0}'),
    //                                   ElevatedButton(
    //                                       onPressed: () {
    //                                         if ((widget
    //                                                     .productCartModel
    //                                                     .productInCart
    //                                                     .inventoryQuantity ??
    //                                                 99) >
    //                                             (widget
    //                                                     .productCartModel
    //                                                     .productInCart
    //                                                     .quantity ??
    //                                                 0)) {
    //                                           widget.onChangeQuantity((widget
    //                                                       .productCartModel
    //                                                       .productInCart
    //                                                       .quantity ??
    //                                                   0) +
    //                                               1);
    //                                         }
    //                                       },
    //                                       style: ElevatedButton.styleFrom(
    //                                           shape: const CircleBorder()),
    //                                       child: const Text('+')),
    //                                 ],
    //                               ),
    //                             ),
    //                             const SizedBox(
    //                               width: 16,
    //                             ),
    //                             Text(
    //                                 'Kho ${widget.productCartModel.productInCart.inventoryQuantity?.toString() ?? ''}'),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.end,
    //                     children: [
    //                       SizedBox(
    //                           height: 24,
    //                           width: 24,
    //                           child: Obx(
    //                             () => Checkbox(
    //                               value: isSelected.value,
    //                               onChanged: (value) {
    //                                 isSelected.value = !isSelected.value;
    //                                 widget.onCheckChange(isSelected.value);
    //                               },
    //                             ),
    //                           )),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //         // Divider(
    //         //   thickness: 8,
    //         // )
    //       ],
    //     ),
    //   ),
    // );
    return Slidable(
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),
        extentRatio: 0.25,
        // A pane can dismiss the Slidable.
        // dismissible: DismissiblePane(onDismissed: () {
        //   widget.showDel();
        // }),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              widget.showDel();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xoá',
          ),
        ],
      ),
      // onDismissed: (direction) {
      //   // if (direction == DismissDirection.startToEnd) {
      //   widget.showDel();
      //   // }
      //   // Then show a snackbar.
      // },
      // Show a red background as the item is swiped away.
      // background: Container(color: Colors.red),
      key: ValueKey(widget.productCartModel.productInCart),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.only(/* left: 4, right: 4, */ top: 4.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: NetworkImage(cartItem.imageUrl),
                      //   fit: BoxFit.cover,
                      // ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ImageComponent(
                      isShowBorder: false,
                      imageUrl: domain +
                          (widget.productCartModel.productInCart.images
                                  ?.firstWhereOrNull(
                                      (element) => element.url != null)
                                  ?.url ??
                              ''),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productCartModel.productInCart.name ?? '',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Phân loại: ${widget.colorName} || ${widget.sizeName}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Giá: ${formatMoney(widget.productCartModel.productInCart.price ?? 0)}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Container(
                              width: 36.0,
                              height: 36.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  widget.onChangeQuantity((widget
                                              .productCartModel
                                              .productInCart
                                              .quantity ??
                                          0) -
                                      1);
                                },
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Container(
                              width: 64.0,
                              height: 38,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(8)),
                              child: TextField(
                                controller: TextEditingController(
                                    text: widget
                                        .productCartModel.productInCart.quantity
                                        ?.toString()),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                style: const TextStyle(fontSize: 16.0),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 4),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                onChanged: (value) {
                                  final count = int.parse(value);
                                  if (count >
                                      (widget.productCartModel.productInCart
                                              .inventoryQuantity ??
                                          1)) {
                                    widget.onChangeQuantity(widget
                                            .productCartModel
                                            .productInCart
                                            .inventoryQuantity ??
                                        1);
                                    DialogCommon().showAlertDialog(
                                        context: context,
                                        title:
                                            'Bạn đã chọn quá số lượng sản phẩm trong kho');
                                  } else {
                                    widget.updateQuantityNoRefesh(count);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Container(
                              width: 36.0,
                              height: 36.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  if ((widget.productCartModel.productInCart
                                              .inventoryQuantity ??
                                          99) >
                                      (widget.productCartModel.productInCart
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
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Kho: ${widget.productCartModel.productInCart.inventoryQuantity?.toString() ?? ''}',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
