import 'package:get/get.dart';

import 'my_order_view_model.dart';

class MyOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyOrderViewModel());
  }
}
