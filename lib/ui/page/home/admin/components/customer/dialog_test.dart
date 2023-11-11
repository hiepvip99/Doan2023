import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/extendsion/extendsion.dart';
import 'package:web_app/model/network/customer_model.dart';
import 'package:web_app/service/network/customer_service.dart';

import '../../../../../../constant.dart';
import '../product_manager/product_manager_view.dart';
import 'customer_view_model.dart';

class CustomerInfoDialog extends StatefulWidget {
  final String? accountId;
  const CustomerInfoDialog({super.key, required this.accountId});

  @override
  State<CustomerInfoDialog> createState() => _CustomerInfoDialogState();
}

class _CustomerInfoDialogState extends State<CustomerInfoDialog> {
  // ID của khách hàng, bạn cần truyền giá trị này từ nơi gọi dialog
  final viewModel = Get.find<CustomerViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getCustomer(widget.accountId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: ImageComponent(
                imageUrl: domain + (viewModel.customerInfo.value.image ?? ''),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                // shrinkWrap: true,
                children: [
                  ListTile(
                    title:
                        Text('Tên: ${viewModel.customerInfo.value.name ?? ''}'),
                  ),
                  ListTile(
                    title: Text(
                        'Số điện thoại: ${viewModel.customerInfo.value.phoneNumber}'),
                  ),
                  ListTile(
                    title: Text(
                        'Ngày sinh: ${formatDate(viewModel.customerInfo.value.dateOfBirth)}'),
                  ),
                  ListTile(
                    title: Text('Email: ${viewModel.customerInfo.value.email}'),
                  ),
                  ListTile(
                    title: Text(
                        'Địa chỉ: ${viewModel.customerInfo.value.address?.map((e) => '\n - $e').toList().join()}'),
                  ),
                  ListTile(
                    title: Text(
                        'Số tiền đã mua: ${viewModel.customerInfo.value.totalAmountSpent}'),
                  ),
                  ListTile(
                    title: Text(
                        'Số đơn hàng đã hoàn thành: ${viewModel.customerInfo.value.totalOrder}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
