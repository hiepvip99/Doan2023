// import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../../model/network/customer_model.dart';
// import '../../../../../../model/network/order_manager_model.dart';
import '../../../../../../service/network/customer_service.dart';

class CustomerViewModel extends GetxController {
  RxList<Customer> customerList = RxList([]);
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  RxBool loading = false.obs;
  RxString keyword = ''.obs;

  Rx<Customer> customerInfo = Rx(Customer());

  CustomerService customerService = CustomerService();

  void onStepChange(String? value) {
    selectedItem.value = value ?? '10';
    currentPage.value = 1;
    getAllCustomer();
  }

  void onPageChange(int index) {
    currentPage.value = index + 1;
    getAllCustomer();
    // if (kDebugMode) {
    //   print(currentPage.value);
    // }
  }

  Future<void> getAllCustomer() async {
    customerService
        .getAllCustomer(
            currentPage: currentPage.value,
            keyword: keyword.value,
            step: int.tryParse(selectedItem.value))
        .then((value) {
      if (value?.customer != null) {
        customerList.value = value?.customer ?? [];
      }
    });
  }

  Future<void> getCustomer(String? accountId) async {
    customerService.getCustomerById(accountId: accountId).then((value) {
      if (value != null) {
        customerInfo.value = value;
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllCustomer();
  }
}
