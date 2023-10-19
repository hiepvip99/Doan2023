import 'package:get/get.dart';

import '../../../../../../model/network/customer_model.dart';
import '../../../../../../service/network/customer_service.dart';

class EditProfileViewModel extends GetxController {
  Rx<Customer> customerInfo = Rx(Customer());
  CustomerService customerService = CustomerService();

  static const accid = 3;

  Future<void> updateInfomation() async {
    customerService.getCustomerById(accountId: accid).then((value) {
      if (value != null) {
        customerInfo.value = value;
      }
    });
  }
}
