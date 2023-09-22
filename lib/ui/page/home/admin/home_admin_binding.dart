import 'package:get/get.dart';
import 'package:web_app/ui/page/home/admin/components/category_manager/category_view_model.dart';

import 'components/statistical/statistical_view_model.dart';
import 'home_admin_controller.dart';
import 'components/account_manager/account_manager_controller.dart';
import 'components/manufacturers_manager/manufacturers_manager_view_model.dart';
import 'components/order_manager/order_manager_view_model.dart';
import 'components/product_manager/product_manager_view_model.dart';

class HomeAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeAdminController());
    Get.lazyPut(() => AccountManagerViewModel());
    Get.lazyPut(() => ManufacturersViewModel());
    Get.lazyPut(() => ProductManagerViewModel());
    Get.lazyPut(() => OrderManagerViewModel());
    Get.lazyPut(() => CategoryViewModel());
    Get.lazyPut(() => StatisticalViewModel());
  }
}
