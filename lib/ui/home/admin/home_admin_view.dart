import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/home/admin/components/account_manager/account_manager_view.dart';

import 'components/list_item.dart';
import 'components/manufacturers_manager/manufacturers_manager_view.dart';
import 'home_admin_controller.dart';

class HomeAdmin extends StatelessWidget {
  HomeAdmin({super.key});
  static const router = '/HomeAdmin';

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
        default:
          return AccountManagerView();
      }
    });
  }
}
