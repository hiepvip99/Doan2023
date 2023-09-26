import 'package:get/get.dart';

import '../../../../../../model/network/customer_model.dart';
import '../../../../../../model/network/order_manager_model.dart';

class CustomerViewModel extends GetxController {
  RxList<Customer> customerList = RxList([]);
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  RxBool loading = false.obs;
  RxString keyword = ''.obs;

  void onStepChange(String? value) {
    selectedItem.value = value ?? '10';
    currentPage.value = 1;
    // getCategoryList();
  }

  void onPageChange(int index) {
    currentPage.value = index + 1;
    // getManufacturerList();
    print(currentPage.value);
  }
}
