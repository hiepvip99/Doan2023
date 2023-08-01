import 'package:get/get.dart';
import 'package:web_app/ui/home/admin/home_admin_controller.dart';

class HomeAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeAdminController());
  }
}
