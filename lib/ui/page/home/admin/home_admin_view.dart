import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';

import 'components/account_manager/account_manager_view.dart';
import 'components/list_item.dart';
import 'components/manufacturers_manager/manufacturers_manager_view.dart';
import 'components/order_manager/order_manager_view.dart';
import 'components/product_manager/product_manager_view.dart';
import 'components/statistical/statistical_view.dart';
import 'home_admin_controller.dart';

class HomeAdmin extends StatelessWidget {
  HomeAdmin({super.key});
  static const route = '/HomeAdmin';

  final _controller = Get.find<HomeAdminController>();
  final GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
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
