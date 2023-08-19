import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/account_manager/account_manager_view.dart';
import 'components/list_item.dart';
import 'components/manufacturers_manager/manufacturers_manager_view.dart';
import 'components/order_manager/order_manager_view.dart';
import 'components/product_manager/product_manager.dart';
import 'components/statistical/statistical_view.dart';
import 'home_admin_controller.dart';

class HomeAdmin extends StatelessWidget {
  HomeAdmin({super.key});
  static const route = '/HomeAdmin';

  final _controller = Get.find<HomeAdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LeftMenu(controller: _controller),
          // Expanded(child: AccountManagerView()),
          // Expanded(child: ManufacturersManagerView()),
          Expanded(child: getRightBody()),
        ],
      ),
    );
  }

  Widget getRightBody() {
    return Obx(() {
      switch (_controller.indexSelected.value) {
        case 0:
          return AccountManagerView();
        case 1:
          return ManufacturersManagerView();
        case 2:
          return ProductManagerView();
        case 3:
          return OrderManagerView();
        case 4:
          return const LineChartSample1();
        // case 8:
        //   return const LineChartSample1();
        default:
          return AccountManagerView();
      }
    });
  }
}
