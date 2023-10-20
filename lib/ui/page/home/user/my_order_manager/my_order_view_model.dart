// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:web_app/service/network/order_service.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';
import 'package:web_app/ui/page/home/user/my_order_manager/order_detail/order_detail_view.dart';
import 'package:web_app/ui/page/home/user/my_order_manager/order_detail/order_detail_view_model.dart';

import '../../../../../model/network/color_model.dart';
import '../../../../../model/network/order_manager_model.dart';
import '../../../../../model/network/size_model.dart';
import '../../../../../service/local/save_data.dart';
import '../../../../../service/network/color_service.dart';
import '../../../../../service/network/size_service.dart';

class MyOrderViewModel extends GetxController {
  final RxList<StatusOrder> listStatusOrder = RxList();
  final RxList<Order> listOrder = RxList();
  RxBool loading = false.obs;

  List<List<Order>> list = [];

  final OrderService networkService = OrderService();
  ColorService colorNetworkService = ColorService();
  SizeService sizeNetworkService = SizeService();

  RxList<Color> colorList = RxList();
  RxList<Size> sizeList = RxList();
  final RxList<List<Order>> orderListZ = RxList();

  final dialog = Get.find<DialogCommon>();

  @override
  void onInit() {
    super.onInit();
    getAllProduct();
    getInfomationForProduct();
  }

  Future<void> getInfomationForProduct() async {
    colorNetworkService
        .getAllColor()
        .then((value) => colorList.value = value?.color ?? []);
    sizeNetworkService
        .getAllSize()
        .then((value) => sizeList.value = value?.size ?? []);
  }

  Future<void> getAllProduct() async {
    loading.value = true;
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
    loading.value = false;
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

  void toDetailOrderScreen(Order order) {
    Get.toNamed(OrderDetailView.route,
        arguments: OrderDetailViewArgument(
            order: order, status: listStatusOrder.value));
  }
}
