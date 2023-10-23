import 'package:get/get.dart';
import 'package:web_app/model/network/discount_model.dart';

import '../../../../../service/network/discount_service.dart';

class DiscountViewModel extends GetxController {
  RxList<Discount> discountList = RxList();
  DiscountService discountService = DiscountService();
  RxBool loading = false.obs;
  Future<void> getAllFavoriteProduct() async {
    loading.value = true;
    await discountService.getAllDiscount().then((value) {
      discountList.value = value?.data ?? [];
      // totalPage.value = value?.totalPages ?? 1;
    });
    loading.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllFavoriteProduct();
  }
}
