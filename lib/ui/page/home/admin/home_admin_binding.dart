import 'package:get/get.dart';

import 'home_admin_controller.dart';
import 'components/account_manager/account_manager_controller.dart';
import 'components/manufacturers_manager/manufacturers_manager_controller.dart';
import 'components/order_manager/order_manager_view_model.dart';
import 'components/product_manager/product_manager_view_model.dart';

class HomeAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeAdminController());
    Get.lazyPut(() => AccountManagerViewModel());
    Get.lazyPut(() => ManufacturersManagerController());
    Get.lazyPut(() => ProductManagerViewModel());
    Get.lazyPut(() => OrderManagerViewModel());
  }
}
