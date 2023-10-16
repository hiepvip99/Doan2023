// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          'Địa chỉ nhận hàng: ${viewModel.customer.value.address?.length != 0 ? viewModel.customer.value.address?.first : ''}'),
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
                                              ? itemDetail.productInCart.images
                                                      ?.first.url ??
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Xử lý khi nhấn nút đặt hàng
                },
                child: const Text('Đặt hàng'),
              ),
            ],
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
