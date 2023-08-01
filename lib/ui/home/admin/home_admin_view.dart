import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/list_item.dart';
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
        ],
      ),
    );
  }
}
