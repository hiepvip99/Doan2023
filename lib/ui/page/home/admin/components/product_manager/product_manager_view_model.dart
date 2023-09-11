// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../model/network/product_manager_model.dart';
import '../../../../../../service/network/product_service.dart';
import '../../../../../dialog/dialog_common.dart';
import 'components/dialog_product.dart';

class ProductManagerViewModel extends GetxController {
  RxList<Product> productList = RxList([]);
  Rx<Product> itemAdd = Rx(Product());
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  RxBool loading = false.obs;
  RxString keyword = ''.obs;
  ProductService networkService = ProductService();

  void onPageChange(int index) {
    currentPage.value = index + 1;
    getAllProduct();
    print(currentPage.value);
  }

  void onStepChange(String? value) {
    selectedItem.value = value ?? '10';
    currentPage.value = 1;
    getAllProduct();
  }

  @override
  void onInit() {
    super.onInit();
    getAllProduct();
  }

  Future<void> getAllProduct() async {
    loading.value = true;
    await networkService
        .getAllProduct(
            currentPage: currentPage.value,
            step: int.tryParse(selectedItem.value) ?? 10,
            keyword: keyword.value)
        .then((value) {
      productList.value = value?.product ?? [];
      totalPage.value = value?.totalPages ?? 1;
    });
    loading.value = false;
  }

  // String? get

  void removeProduct(int id) {
    productList.removeWhere((element) => element.id == id);
  }

  void showDelete(int id, BuildContext context) {
    Get.find<DialogCommon>().showDeleteConfirmation(
      context,
      () => removeProduct(id),
      text: 'sản phẩm có id: $id',
    );
  }

  void showAdd(BuildContext context) {
    DialogProduct(viewModel: this).addProductDialog(context, itemAdd);
  }
}

// class ProductModel {
//   int? id;
//   String? image;
//   String? name;
//   int? price;
//   int? manufacturerId;
//   String? gender;
//   int? quatity;
//   List<int>? colorId;
//   ProductModel({
//     this.id,
//     this.image,
//     this.name,
//     this.price,
//     this.manufacturerId,
//     this.gender,
//     this.quatity,
//     this.colorId,
//   });
// }

// class Product
