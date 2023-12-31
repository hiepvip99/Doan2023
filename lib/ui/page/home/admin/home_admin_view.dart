import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/page/home/admin/components/category_manager/category_view.dart';
import 'package:web_app/ui/page/home/admin/components/customer/customer_view.dart';
import 'package:web_app/ui/page/home/user/discount/discount_view.dart';

import 'components/account_manager/account_manager_view.dart';
import 'components/category_manager/test_ui.dart';
import 'components/discount_manager/discount_manager_view.dart';
import 'components/list_item.dart';
import 'components/manufacturers_manager/manufacturers_manager_view.dart';
import 'components/order_manager/order_manager_view.dart';
import 'components/product_manager/product_manager_view.dart';
import 'components/setting_admin/logout_view.dart';
import 'components/statistical/statistical_view.dart';
import 'home_admin_controller.dart';

class HomeAdmin extends StatelessWidget {
  HomeAdmin({super.key});
  static const route = '/HomeAdmin';

  final _controller = Get.find<HomeAdminController>();
  final GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return const Column(
        children: [
          Text('Bạn chỉ có thể đăng nhập tài khoản người dùng trên windows'),
          LogoutView(),
        ],
      );
    }
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Row(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       LeftMenu(controller: _controller),
    //       // Expanded(child: AccountManagerView()),
    //       // Expanded(child: ManufacturersManagerView()),
    //       Expanded(child: getRightBody()),
    //     ],
    //   ),
    // );
    return Scaffold(
        body: SliderDrawer(
      key: _key,
      isDraggable: false,
      sliderCloseSize: 70,
      sliderOpenSize: 270,
      appBar: const SizedBox(),
      // appBar: const SliderAppBar(
      //     appBarColor: Colors.white,
      //     title: Text('title',
      //         style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700))),
      slider: LeftMenu(
        onCloseOrOpenDrawer: () {
          if (_key.currentState?.isDrawerOpen == true) {
            _key.currentState?.closeSlider();
          } else {
            _key.currentState?.openSlider();
          }
          // _key.currentState?.openOrClose();
        },
        controller: _controller,
      ),
      child: Row(
        children: [
          Expanded(child: getRightBody()),
          const SizedBox(
            width: 70,
          )
        ],
      ),
    ));
  }

  Widget getRightBody() {
    return Obx(() {
      switch (_controller.indexSelected.value) {
        case 0:
          return AccountManagerView();
        // case 1:
        //   return const ManufacturersManagerView();
        case 1:
          return const CategoryTest();
        // return const CategoryManagerView();
        case 2:
          return const ProductManagerView();
        case 3:
          return OrderManagerView();
        case 4:
          return const Statistical();
        case 5:
          return const DiscountManagerView();
        case 6:
          return CustomerView();
        case 7:
          return const LogoutView();
        default:
          return AccountManagerView();
      }
    });
  }
}
