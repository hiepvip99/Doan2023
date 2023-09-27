import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/product/product_view_model.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductViewModel());
  }
}
