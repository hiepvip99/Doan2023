import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/discount/discount_view_model.dart';

class DiscountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscountViewModel());
  }
}
