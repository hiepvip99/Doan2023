// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Họ và tên',
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
                    // Text
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sản phẩm',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Hiển thị danh sách sản phẩm
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    viewModel.orderProduct.value.length, // Số lượng sản phẩm
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: Text('Sản phẩm ${index + 1}'),
                    subtitle: const Text('Giá: 100.000 đ'),
                    trailing: const Text('Số lượng: 1'),
                  );
                },
              ),
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
}
