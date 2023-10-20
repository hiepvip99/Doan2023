import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/profile/my_profile/address_manager/address_manager_view_model.dart';

class AddressManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddressManagerViewModel());
  }
}
