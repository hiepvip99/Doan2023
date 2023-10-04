import 'package:get/get.dart';

import '../../../../../model/network/product_manager_model.dart';
import '../../../../../service/network/product_service.dart';

class SearchViewModel extends GetxController {
  RxList<Product> productList = RxList();
  RxBool loading = false.obs;
  RxString keyword = ''.obs;
  ProductService networkService = ProductService();
  RxInt currentPage = 1.obs;
  // RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  Future<void> getAllProduct() async {
    loading.value = true;
    await networkService
        .getAllProduct(
            currentPage: currentPage.value,
            step: int.tryParse(selectedItem.value) ?? 10,
            keyword: keyword.value)
        .then((value) {
      productList.clear();
      productList.value = value?.product ?? [];
      // totalPage.value = value?.totalPages ?? 1;
    });
    loading.value = false;
  }
}
