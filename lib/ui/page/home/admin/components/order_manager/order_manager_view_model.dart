// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../../../../../../model/network/order_manager_model.dart';
import '../../../../../../service/network/order_service.dart';
import '../../../../../dialog/dialog_common.dart';
import '../product_manager/product_manager_view_model.dart';

class OrderManagerViewModel extends GetxController {
  RxList<Order> listOrder = RxList();
  RxList<StatusOrder> listStatusOrder = RxList();
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  RxBool loading = false.obs;
  RxString keyword = ''.obs;
  RxString idSearch = ''.obs;
  RxString dateSearch = ''.obs;

  final dialog = DialogCommon();
  OrderService networkService = OrderService();
  
  void onPageChange(int index) {
    currentPage.value = index + 1;
    getOrderList();
    print(currentPage.value);
  }

  void onStepChange(String? value) {
    selectedItem.value = value ?? '10';
    currentPage.value = 1;
    getOrderList();
  }

  @override
  void onInit() {
    super.onInit();
    getOrderList();
  }

  Future<void> getOrderList() async {
    loading.value = true;
    await networkService
        .getAllOrder(
      currentPage: currentPage.value,
      step: int.tryParse(selectedItem.value) ?? 10,
    )
        .then((value) {
      if (value != null) {
        listOrder.clear();
        listOrder.value = value.order ?? [];
        totalPage.value = value.totalPages ?? 1;
        listStatusOrder.clear();
        listStatusOrder.value = value.statusObj ?? [];
      }
    });
    loading.value = false;
  }

  Future<void> addOrder(
    Order data,
  ) async {
    await networkService.addOrder(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(Get.context!, "Thêm đơn hàng thành công");
        }
        getOrderList();
      }
    });
  }

  Future<void> updateOrder(
    Order data,
  ) async {
    await networkService.updateOrder(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          dialog.showSuccessDialog(Get.context!, "Sửa đơn hàng thành công");
        }
        getOrderList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }

  Future<void> deleteOrder(
    Order data,
  ) async {
    await networkService.deleteOrder(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(Get.context!, "Xóa đơn hàng thành công");
        }
        getOrderList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }

  Future<void> changeStatus(
    Order data,
  ) async {
    await networkService.changeStatus(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(
              Get.context!, "Thay đổi trạng thái đơn hàng thành công");
        }
        getOrderList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }
}
