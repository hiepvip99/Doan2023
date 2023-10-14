import 'package:get/get.dart';

import 'cart_view_model.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartViewModel());
  }
}
