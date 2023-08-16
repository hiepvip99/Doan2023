import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/home_user_controller.dart';

class HomeUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeUserController());
  }
}
