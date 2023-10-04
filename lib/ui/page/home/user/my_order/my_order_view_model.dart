import 'package:get/get.dart';
import 'package:web_app/service/network/order_service.dart';

import '../../../../../model/network/order_manager_model.dart';
import '../../../../../service/local/save_data.dart';

class MyOrderViewModel extends GetxController {
  final RxList<StatusOrder> listStatusOrder = RxList();
  final RxList<Order> listOrder = RxList();

  List<List<Order>> list = [];

  final OrderService networkService = OrderService();

  @override
  void onInit() {
    super.onInit();
    getAllProduct();
  }

  Future<void> getAllProduct() async {
    // loading.value = true;
    final accId = '3';
    // final accId = DataLocal.getAccountId() ?? '';
    await networkService.getAllOrder(accountId: accId, step: 100).then((value) {
      listStatusOrder.value = value?.statusObj ?? [];
      listOrder.value = value?.order ?? [];
      // totalPage.value = value?.totalPages ?? 1;
    });
    // loading.value = false;
  }
}
