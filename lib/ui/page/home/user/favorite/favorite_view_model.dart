import 'package:get/get.dart';

import '../../../../../model/network/product_manager_model.dart';
import '../../../../../service/network/product_service.dart';
import '../../../../dialog/dialog_common.dart';

class FavoriteViewModel extends GetxController {
  ProductService networkService = ProductService();

  RxInt currentPage = 1.obs;
  RxString keyword = ''.obs;
  RxBool loading = false.obs;
  RxString selectedItem = '10'.obs;

  final accId = 3;

  RxList<Product> productList = RxList();

  final dialog = Get.find<DialogCommon>();

  Future<void> getAllFavoriteProduct() async {
    loading.value = true;
    await networkService
        .getAllFavoriteProduct(
            accountId: accId,
            currentPage: currentPage.value,
            step: int.tryParse(selectedItem.value) ?? 10)
        .then((value) {
      productList.value = value?.product ?? [];
      // totalPage.value = value?.totalPages ?? 1;
    });
    loading.value = false;
  }

  Future<void> removeFavorite(List<Favorite> favorite) async {
    final List<Favorite> favoriteSend = favorite
        .map((e) => Favorite(productId: e.productId, accountId: accId))
        .toList();
    await dialog.showDeleteConfirmation(Get.context!, () async {
      loading.value = true;
      await networkService.removeFavorite(favoriteSend).then((value) {
        dialog.showAlertDialog(
            context: Get.context!,
            title: 'Bạn đã xoá thành công sản phẩm khỏi danh sách yêu thích');
      });
      loading.value = false;
    }, text: 'Bạn có muốn xoá sản phẩm khỏi danh sách yêu thích');
  }
}
