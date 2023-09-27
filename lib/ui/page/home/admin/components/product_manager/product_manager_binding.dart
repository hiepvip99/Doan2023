import 'package:get/get.dart';
import 'package:web_app/ui/page/home/admin/components/product_manager/product_manager_view_model.dart';

class ProductManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductManagerViewModel());
  }
}
