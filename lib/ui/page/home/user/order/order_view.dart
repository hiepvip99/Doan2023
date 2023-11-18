// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/loading_widget.dart';
import 'package:web_app/ui/component_common/textfield_beautiful.dart';

import '../../../../../constant.dart';
import '../../../../../extendsion/extendsion.dart';
import '../../../../component_common/close_button.dart';
import '../../admin/components/product_manager/product_manager_view.dart';
import 'order_view_model.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});
  static String route = '/OrderView';

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final viewModel = Get.find<OrderViewModel>();
  TextEditingController txtDiscountCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Đặt hàng'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thông tin khách hàng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => Text(
                    'Họ và tên: ${viewModel.customer.value.name}',
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.location_on,
                        ),
                      ),
                      Expanded(
                          child: Obx(
                        () => Text(
                            'Địa chỉ nhận hàng: ${viewModel.radioAddressValue.value}'),
                      )),
                      InkWell(
                          borderRadius: BorderRadius.circular(50),
                          // radius: 50,
                          onTap: () {
                            showChooseAddress(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.edit),
                          )),
                      // Text
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Text(
                    'Số điện thoại: ${viewModel.customer.value.phoneNumber}',
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sản phẩm',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Hiển thị danh sách sản phẩm
                Container(
                  color: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      if (viewModel.orderProduct.value.length != 0)
                        ...viewModel.orderProduct.value.map(
                          (itemDetail) => Container(
                            // color: Colors.blue,
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: ImageComponent(
                                        isShowBorder: false,
                                        imageUrl: domain +
                                            (itemDetail.productInCart.images
                                                        ?.length !=
                                                    0
                                                ? itemDetail.productInCart
                                                        .images?.first.url ??
                                                    ''
                                                : '')),
                                  ),
                                  title: Text(
                                    itemDetail.productInCart.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                      'Số lượng: ${itemDetail.productInCart.quantity ?? 0} || ${formatMoney(itemDetail.productInCart.price ?? 0)}'),
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 65,
                                    ),
                                    Obx(
                                      () => Text(
                                          'Phân loại: ${viewModel.getColorName(itemDetail.productInCart.colorId)} || ${viewModel.getSizeName(itemDetail.productInCart.sizeId)}'),
                                    )
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Text('${viewModel.order.totalQuantity} sản phẩm'),
                            Text(
                                'Tổng giá trị: ${formatMoney(viewModel.getTotalPrice())}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // ListView.builder(
                //   physics: const NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   itemCount:
                //       viewModel.orderProduct.value.length, // Số lượng sản phẩm
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       contentPadding: EdgeInsets.zero,
                //       leading: SizedBox(
                //         width: 50,
                //         height: 50,
                //         child: ImageComponent(
                //             isShowBorder: false,
                //             imageUrl: domain +
                //                 (viewModel.orderProduct.value[index].productInCart
                //                             .images?.length !=
                //                         0
                //                     ? viewModel.orderProduct.value[index]
                //                             .productInCart.images?.first.url ??
                //                         ''
                //                     : '')),
                //       ),
                //       title: Text(
                //         viewModel.orderProduct.value[index].productInCart.name ??
                //             '',
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //       subtitle: Text(
                //           'Số lượng: ${viewModel.orderProduct.value[index].productInCart.quantity ?? 0} || ${viewModel.orderProduct.value[index].productInCart.price} đ'),
                //     );
                //   },
                // ),
                Column(
                  children: [
                    RadioListTile(
                      title: const Text('Thanh toán khi nhận hàng'),
                      value: 'Thanh toán khi nhận hàng',
                      groupValue: viewModel.radioselectedPaymentMethod.value,
                      onChanged: (value) {
                        setState(() {
                          viewModel.radioselectedPaymentMethod.value =
                              value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Thanh toán qua Qr'),
                      value: 'Thanh toán qua Qr',
                      groupValue: viewModel.radioselectedPaymentMethod.value,
                      onChanged: (value) {
                        setState(() {
                          viewModel.radioselectedPaymentMethod.value =
                              value.toString();
                        });
                        viewModel.genarateQr();
                      },
                    ),
                    // RadioListTile(
                    //   title: const Text('Thanh toán qua Zalo Pay'),
                    //   value: 'Thanh toán qua Zalo Pay',
                    //   groupValue: viewModel.radioselectedPaymentMethod.value,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       viewModel.radioselectedPaymentMethod.value =
                    //           value.toString();
                    //     });
                    //   },
                    // ),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(
                  () => viewModel.loading.value
                      ? const Column(
                          children: [
                            Text('Đang tải qr thanh toán cho bạn'),
                            Gap(16),
                            LoadingWidget(),
                          ],
                        )
                      : Visibility(
                          visible: viewModel.radioselectedPaymentMethod.value ==
                                  'Thanh toán qua Qr' &&
                              viewModel.base64Image.value.trim().isNotEmpty,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Image.memory(
                                    base64Decode(viewModel.base64Image.value
                                        .split('data:image/png;base64,')
                                        .last),
                                  ),
                                  const Gap(16),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                            'Sau khi thanh toán qua qr bạn hãy gửi ảnh vào zalo của shop nhé zalo là : 098.122.2070'),
                                      ),
                                      const Gap(16),
                                      ElevatedButton(
                                          onPressed: () {
                                            Clipboard.setData(
                                                const ClipboardData(
                                                    text: '0981222070'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('Đã sao chép zalo'),
                                              ),
                                            );
                                          },
                                          child: const Text('Sao chép zalo:'))
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFieldBeautiful(
                          title: 'Thêm mã giảm giá',
                          controller: txtDiscountCode),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: () {
                        // Xử lý khi nhấn nút đặt hàng
                        // viewModel.createOrder();
                      },
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          viewModel.applyDiscount(txtDiscountCode.text.trim());
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue.shade700,
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 11, horizontal: 8),
                            child: const Text(
                              'Áp dụng',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Visibility(
                    visible: viewModel.discount.value > 0,
                    child: Text(
                        'Đã áp dụng thành công mã giảm giá giảm ${formatMoney(viewModel.discount.value)}')),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nhấn nút đặt hàng
                    viewModel.createOrder();
                  },
                  child: const Text('Đặt hàng'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showChooseAddress(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Chọn địa chỉ'),
                  CloseButtonCommon(),
                ],
              ),
              if (viewModel.customer.value.address?.length != 0)
                Obx(
                  () => Column(
                    children: viewModel.customer.value.address!
                        .map((e) => RadioListTile(
                              value: e,
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              groupValue: viewModel.radioAddressValue.value,
                              title: Text(e),
                              // selected: true,
                              onChanged: (value) {
                                viewModel.radioAddressValue.value = e;
                                Get.back();
                              },
                            ))
                        .toList(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
