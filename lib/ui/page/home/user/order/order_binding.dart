import 'package:get/get.dart';

import 'order_view_model.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderViewModel());
  }
}
