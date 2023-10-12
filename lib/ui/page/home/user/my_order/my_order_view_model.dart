import 'package:get/get.dart';
import 'package:web_app/service/network/order_service.dart';
import 'package:web_app/ui/page/home/user/my_order/order_detail/order_detail_view.dart';
import 'package:web_app/ui/page/home/user/my_order/order_detail/order_detail_view_model.dart';

import '../../../../../model/network/order_manager_model.dart';
import '../../../../../service/local/save_data.dart';

class MyOrderViewModel extends GetxController {
  final RxList<StatusOrder> listStatusOrder = RxList();
  final RxList<Order> listOrder = RxList();

  List<List<Order>> list = [];

  final OrderService networkService = OrderService();

  final RxList<List<Order>> orderListZ = RxList();

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

      listStatusOrder.value.map((e) {
        var orderList = listOrder.value;
        orderList.retainWhere((element) => e.id == element.statusId);
        if (orderList.isEmpty) {
          orderList = [];
        }
        orderListZ.add(orderList);
      });
      // totalPage.value = value?.totalPages ?? 1;
    });
    list.length;
    // loading.value = false;
  }

  void toDetailOrderScreen(Order order) {
    Get.toNamed(OrderDetailView.route,
        arguments: OrderDetailViewArgument(
            order: order, status: listStatusOrder.value));
  }
}
