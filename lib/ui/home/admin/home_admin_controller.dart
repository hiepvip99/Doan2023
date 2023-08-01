import 'package:get/get.dart';

import 'components/account_manager/account_manager_controller.dart';

class HomeAdminController extends GetxController {
  final RxInt indexSelected = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dependenciesBody();
  }

  void dependenciesBody() {
    Get.lazyPut(() => AccountManagerController());
  }
}
