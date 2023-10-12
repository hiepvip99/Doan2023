// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../../../../../../model/network/order_manager_model.dart';

class OrderDetailViewModel extends GetxController {
  Order order = Order();
  final RxList<StatusOrder> listStatusOrder = RxList();

  RxString statusName = ''.obs;

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
