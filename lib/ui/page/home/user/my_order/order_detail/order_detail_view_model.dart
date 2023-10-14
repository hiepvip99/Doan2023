// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../../../../../../model/network/order_manager_model.dart';
import '../../../../../../service/network/order_service.dart';
import '../../../../../dialog/dialog_common.dart';
import '../my_order_view_model.dart';

class OrderDetailViewModel extends GetxController {
  Order order = Order();
  final RxList<StatusOrder> listStatusOrder = RxList();

  RxString statusName = ''.obs;

  final OrderService networkService = OrderService();

  Future<void> changeStatus(int status, String text) async {
    order.statusId = status;
    // loading.value = true;
    // final accId = '3';
    // final accId = DataLocal.getAccountId() ?? '';
    await networkService.changeStatus(order).then((value) {
      if (value?.statusCode == 200) {
        Get.back();
        Get.find<DialogCommon>()
            .showSuccessDialog(Get.context!, 'Bạn đã $text thành công');
        Get.find<MyOrderViewModel>().getAllProduct();
      }
    });
    // loading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments;
    if (data is OrderDetailViewArgument) {
      order = data.order;
      listStatusOrder.value = data.status;
      statusName.value = listStatusOrder.value
              .firstWhereOrNull((element) => element.id == order.statusId)
              ?.name ??
          '';
    }
  }
}

class OrderDetailViewArgument {
  List<StatusOrder> status;
  Order order;
  OrderDetailViewArgument({
    this.status = const [],
    required this.order,
  });
}
