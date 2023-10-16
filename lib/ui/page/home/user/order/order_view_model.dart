import 'package:get/get.dart';
import 'package:web_app/model/network/order_manager_model.dart';

import '../../../../../model/network/customer_model.dart';
import '../../../../../service/network/customer_service.dart';
import '../cart/cart_view_model.dart';

class OrderViewModel extends GetxController {
  Rx<Order> order = Rx(Order());

  RxList<ProductCartModel> orderProduct = RxList();

  CustomerService customerService = CustomerService();
  Rx<Customer> customer = Rx(Customer());

  static const accId = 3;

  Future<void> getInfomationForProduct() async {
    customerService
        .getCustomerById(accountId: accId)
        .then((value) => value != null ? customer.value = value : null);
  }

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments;
    if (data is List<ProductCartModel>) {
      orderProduct.value = data;
    }
    getInfomationForProduct();
    accId;
  }
}
