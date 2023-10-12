import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/model/network/order_manager_model.dart';

import '../../../../../../constant.dart';
import '../../../../../../extendsion/extendsion.dart';
import '../../../admin/components/product_manager/product_manager_view.dart';
import 'order_detail_view_model.dart';

class OrderDetailView extends StatelessWidget {
  OrderDetailView({super.key});

  static const route = '/OrderDetailView';

  final viewModel = Get.find<OrderDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trạng thái đơn hàng:',
                  ),
                  Obx(
                    () => Text(
                      viewModel.statusName.value,
                    ),
                  ),
                ],
              ),
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
                        child: Text(
                            'Địa chỉ nhận hàng: ${viewModel.order.deliveryAddress}')),
                    // Text
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 8.0),
                    //   child: Icon(
                    //     Icons.location_on,
                    //   ),
                    // ),
                    Text('Người nhận: ${viewModel.order.customerInfo?.name}'),
                    const SizedBox(
                      height: 8,
                    ),
                    // const Divider(),
                    Text(
                        'Số điện thoại: ${viewModel.order.customerInfo?.phoneNumber}'),
                    const Divider(),
                    Text('Mã đơn hàng: ${viewModel.order.id}'),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Thời gian đặt hàng:'),
                        Text(formatDateTime(
                            viewModel.order.orderDate ?? DateTime(1990))),
                      ],
                    ),
                    const Divider(),
                    // Text
                  ],
                ),
              ),
              Container(
                color: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    if (viewModel.order.details?.length != 0)
                      ...viewModel.order.details!.map(
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
                                          (itemDetail.color?.images?.length != 0
                                              ? itemDetail.color?.images?.first
                                                      .url ??
                                                  ''
                                              : '')),
                                ),
                                title: Text(
                                  itemDetail.product?.name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                    'Số lượng: ${itemDetail.quantity ?? 0} || ${itemDetail.color?.price} đ'),
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
                          Text('${viewModel.order.totalQuantity} sản phẩm'),
                          Text('Tổng giá trị: ${viewModel.order.totalPrice} đ'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              const Text('Phương thức thanh toán'),
              const SizedBox(
                height: 8,
              ),
              Text('${viewModel.order.paymentMethods}'),
              const Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        // height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: getButton()),
              // ElevatedButton(onPressed: () {}, child: Text('Huỷ đơn hàng')),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: ElevatedButton(
                      // style: ElevatedButton.styleFrom(),
                      onPressed:
                          (viewModel.order.statusId ?? 99) < 4 ? null : () {},
                      child: const Text('Yêu cầu trả hàng'))),
            ],
          ),
        ),
      ),
    );
  }

  Widget getButton() {
    return (viewModel.order.statusId ?? 99) < 4
        ? TextButton(onPressed: () {}, child: const Text('Huỷ đơn hàng'))
        : ElevatedButton(
            onPressed: () {}, child: const Text('Đã nhận được hàng'));
  }
}