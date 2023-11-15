import 'package:get/get.dart';
import 'forgot_pass_view_model.dart';

class ForgotPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPassViewModel());
  }
}
