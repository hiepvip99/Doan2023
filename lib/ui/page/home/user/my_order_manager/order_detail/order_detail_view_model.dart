// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../../../../../../model/network/color_model.dart';
import '../../../../../../model/network/order_manager_model.dart';
import '../../../../../../model/network/size_model.dart';
import '../../../../../../service/network/color_service.dart';
import '../../../../../../service/network/order_service.dart';
import '../../../../../../service/network/size_service.dart';
import '../../../../../dialog/dialog_common.dart';
import '../my_order_view_model.dart';

class OrderDetailViewModel extends GetxController {
  Rx<Order> order = Rx(Order());
  final RxList<StatusOrder> listStatusOrder = RxList();

  RxString statusName = ''.obs;

  final OrderService networkService = OrderService();

  Future<void> changeStatus(int status, String text) async {
    order.value.statusId = status;
    order.refresh();
    // loading.value = true;
    // final accId = '3';
    // final accId = DataLocal.getAccountId() ?? '';
    await networkService.changeStatus(order.value).then((value) {
      if (value?.statusCode == 200) {
        order.refresh();
        Get.back();
        Get.find<DialogCommon>()
            .showSuccessDialog(Get.context!, 'Bạn đã $text thành công');
        statusName.value = listStatusOrder.value
                .firstWhereOrNull(
                    (element) => element.id == order.value.statusId)
                ?.name ??
            '';
        Get.find<MyOrderViewModel>().getAllProduct();
      }
    });
    // loading.value = false;
  }

  ColorService colorNetworkService = ColorService();
  SizeService sizeNetworkService = SizeService();

  RxList<Color> colorList = RxList();
  RxList<Size> sizeList = RxList();

  Future<void> getInfomationForProduct() async {
    colorNetworkService
        .getAllColor()
        .then((value) => colorList.value = value?.color ?? []);
    sizeNetworkService
        .getAllSize()
        .then((value) => sizeList.value = value?.size ?? []);
  }

  String getColorName(int? colorId) {
    return colorList
            .firstWhereOrNull((element) => element.id == colorId)
            ?.name ??
        '';
  }

  String getSizeName(int? sizeId) {
    return sizeList.firstWhereOrNull((element) => element.id == sizeId)?.name ??
        '';
  }

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments;
    if (data is OrderDetailViewArgument) {
      order.value = data.order;
      listStatusOrder.value = data.status;
      statusName.value = listStatusOrder.value
              .firstWhereOrNull((element) => element.id == order.value.statusId)
              ?.name ??
          '';
    }
    getInfomationForProduct();
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
