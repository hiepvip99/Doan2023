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
  RxBool loading = false.obs;

  RxString base64Image = ''.obs;
  RxString statusName = ''.obs;
  RxBool hasRating = false.obs;
  final OrderService networkService = OrderService();

  Future<void> checkRating(int? orderDetailId, int? productId) async {
    networkService.checkReview(orderDetailId, productId).then((value) {
      hasRating.value = value?.hasReview ?? false;
    });
  }

  Future<void> genarateQr() async {
    loading.value = true;
    int? maxId;
    await networkService.getMaxId().then((value) {
      if (value?.maxId != null) {
        maxId = value?.maxId;
      }
    });
    // base64Image.
    await networkService
        .genarateQr(GetQrGenarate(
            accountNo: '4520561495',
            accountName: 'LE CHI HIEP',
            acqId: 970418,
            amount: order.value.totalPrice,
            addInfo: 'Pay to order id: ${(maxId ?? 0) + 1}',
            format: 'text',
            template: '96KCB5S'))
        .then((value) {
      if (value?.data?.qrDataURL != null) {
        base64Image.value = value?.data?.qrDataURL ?? '';
      }
    });

    loading.value = false;
  }

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
        DialogCommon()
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

  RxList<ColorShoe> colorList = RxList();
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
    genarateQr();
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
