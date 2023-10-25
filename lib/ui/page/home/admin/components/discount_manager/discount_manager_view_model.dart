import 'package:get/get.dart';
import 'package:web_app/service/network/discount_service.dart';

import '../../../../../../model/network/discount_model.dart';
import '../../../../../dialog/dialog_common.dart';

class DiscountManagerViewModel extends GetxController {
  DiscountService discountService = DiscountService();
  RxList<Discount> discountList = RxList();
  RxBool loading = false.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  final dialog = DialogCommon();

  @override
  void onInit() {
    super.onInit();
    getDiscountList();
  }

  Future<void> getDiscountList() async {
    loading.value = true;
    discountService.getAllDiscount().then((value) {
      if (value?.data?.length != 0) {
        discountList.value = value?.data ?? [];
      }
    });
    loading.value = false;
  }

  Future<void> addDiscount(
    Discount data,
  ) async {
    await discountService.addDiscount(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(
              Get.context!, "Thêm nhà sản xuất thành công");
        }
        getDiscountList();
        // Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }

  Future<void> updateDiscount(
    Discount data,
  ) async {
    await discountService.updateDiscount(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          dialog.showSuccessDialog(Get.context!, "Sửa nhà sản xuất thành công");
        }
        getDiscountList();
        // Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }

  Future<void> deleteDiscount(
    Discount data,
  ) async {
    await discountService.deleteDiscount(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(Get.context!, "Xóa nhà sản xuất thành công");
        }
        getDiscountList();
        // Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }
}
