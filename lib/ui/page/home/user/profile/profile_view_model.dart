import 'package:get/get.dart';

import '../../../../../model/network/customer_model.dart';
import '../../../../../service/network/customer_service.dart';

class ProfileViewModel extends GetxController {
  CustomerService customerService = CustomerService();

  final accid = 3;

  Rx<Customer> customerInfo = Rx(Customer());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInfomationCustomer();
  }

  Future<void> getInfomationCustomer() async {
    customerService.getCustomerById(accountId: accid).then((value) {
      if (value != null) {
        customerInfo.value = value;
      }
    });
  }
}
