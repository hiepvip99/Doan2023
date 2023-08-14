import 'package:get/get.dart';
import 'package:web_app/ui/page/home/admin/home_admin_controller.dart';

import 'components/account_manager/account_manager_controller.dart';
import 'components/manufacturers_manager/manufacturers_manager_controller.dart';
import 'components/product_manager/product_manager_view_model.dart';

class HomeAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeAdminController());
    Get.lazyPut(() => AccountManagerController());
    Get.lazyPut(() => ManufacturersManagerController());
    Get.lazyPut(() => ProductManagerViewModel());
  }
}
