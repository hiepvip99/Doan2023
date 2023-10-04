import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_order_view_model.dart';

class MyOrderView extends StatelessWidget {
  MyOrderView({super.key});

  static const route = '/OrderHistoryScreen';

  final viewModel = Get.find<MyOrderViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đặt hàng'),
      ),
      body: Obx(() => DefaultTabController(
          length: viewModel.listStatusOrder.value.length,
          child: Column(
            children: [
              TabBar(
                  labelColor: Colors.black,
                  isScrollable: true,
                  tabs: viewModel.listStatusOrder.value
                      .map((e) => Tab(
                            text: e.name ?? '',
                          ))
                      .toList()),
              Expanded(
                  child: TabBarView(
                      children: viewModel.listStatusOrder.value.map((e) {
                var orderList = viewModel.listOrder.value;
                orderList.retainWhere((element) => e.id == element.statusId);
                return Column(
                  children: [
                    ...orderList.map((item) => Card(
                          child: Text('${item.id}'),
                        )),
                  ],
                );
              }).toList()))
            ],
          ))),
      // body: ListView.builder(
      //   itemCount: 5,
      //   itemBuilder: (context, index) {
      //     return Card(
      //       child: ListTile(
      //         leading: Container(
      //           width: 60,
      //           height: 60,
      //           color: Colors.grey,
      //           child: Center(child: Text('Image')),
      //         ),
      //         title: Text('Order #${index + 1}'),
      //         subtitle: Text('Date: 2023-09-27'),
      //         trailing: Text('\$50'),
      //         onTap: () {
      //           // Xử lý khi người dùng nhấn vào một đơn hàng
      //         },
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
