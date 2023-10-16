import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/my_order_manager/order_detail/order_detail_view_model.dart';

class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => OrderDetailViewModel());
  }
}
