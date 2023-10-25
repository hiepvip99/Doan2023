// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide Color, Size;
import 'package:get/get.dart';
import 'package:web_app/service/network/manufacturer_service.dart';

import '../../../../../../model/network/category_model.dart';
import '../../../../../../model/network/color_model.dart';
import '../../../../../../model/network/manufacturer_model.dart';
import '../../../../../../model/network/product_manager_model.dart';
import '../../../../../../model/network/size_model.dart';
import '../../../../../../service/network/category_service.dart';
import '../../../../../../service/network/color_service.dart';
import '../../../../../../service/network/product_service.dart';
import '../../../../../../service/network/size_service.dart';
import '../../../../../dialog/dialog_common.dart';
import 'components/dialog_product.dart';

class ProductManagerViewModel extends GetxController {
  RxList<Product> productList = RxList();
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  RxBool loading = false.obs;
  RxString keyword = ''.obs;

  RxList<Manufacturer> manufacturerList = RxList();
  RxList<ColorShoe> colorList = RxList();
  RxList<Size> sizeList = RxList();
  RxList<Category> categoryList = RxList();

  ProductService networkService = ProductService();
  ManufacturerService manufacturerNetworkService = ManufacturerService();
  ColorService colorNetworkService = ColorService();
  SizeService sizeNetworkService = SizeService();
  CategoryService categoryNetworkService = CategoryService();

  // RxList<File> filesPicked = RxList();

  // Future<void> pickImage(Product item, listImage) async {
  //   filesPicked.clear();
  //   FilePickerResult? result = await FilePicker.platform
  //       .pickFiles(allowMultiple: true, type: FileType.image);
  //   if (result != null) {
  //     filesPicked.value = result.paths.map((path) => File(path ?? '')).toList();
  //     // await networkService
  //     //     .uploadImages(Images(
  //     //         infoUpload: colorItemProduct,
  //     //         // ignore: invalid_use_of_protected_member
  //     //         listImageUpload: filesPicked.value,
  //     //         productIdUpload: productId))
  //     //     .then((value) {
  //     //   if (value?.statusCode == 200) {
  //     //     DialogCommon().showAlertDialog(
  //     //         context: Get.context!,
  //     //         title: 'Upload ảnh thành công productId: $productId');
  //     //     getAllProduct();
  //     //   } else {
  //     //     DialogCommon().showAlertDialog(
  //     //         context: Get.context!, title: 'Lỗi upload image product');
  //     //   }
  //     // });
  //   } else {
  //     // User canceled the picker
  //   }
  // }

  void onPageChange(int index) {
    currentPage.value = index + 1;
    getAllProduct();
    // print(currentPage.value);
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
    getInfomationForProduct();
  }

  Future<void> uploadImage(Images imageUploads) async {
    networkService.uploadImages(imageUploads).then((value) {
      if (value?.statusCode == 200) {
        DialogCommon().showAlertDialog(
            context: Get.context!,
            title:
                'Cập nhật hình ảnh cho sản phẩm có id:${imageUploads.productIdUpload} thành công');
        getAllProduct();
      } else {
        DialogCommon()
            .showAlertDialog(context: Get.context!, title: 'Lỗi cập nhật ảnh');
      }
    });
  }

  Future<void> getInfomationForProduct() async {
    manufacturerNetworkService
        .getAllManufacturer(step: 1000)
        .then((value) => manufacturerList.value = value?.manufacturer ?? []);
    colorNetworkService
        .getAllColor()
        .then((value) => colorList.value = value?.color ?? []);
    sizeNetworkService
        .getAllSize()
        .then((value) => sizeList.value = value?.size ?? []);
    categoryNetworkService
        .getAllCategory(step: 1000)
        .then((value) => categoryList.value = value?.category ?? []);
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

  Future<void> addProduct(Product addProduct) async {
    loading.value = true;
    await networkService
        .addProduct(ProductManagerModel(item: addProduct))
        .then((value) {
      if (value?.statusCode == 200) {
        DialogCommon().showAlertDialog(
            context: Get.context!,
            title: 'Thêm thành công product ${addProduct.name}');
        getAllProduct();
      } else {
        DialogCommon()
            .showAlertDialog(context: Get.context!, title: 'Lỗi thêm product');
      }
    });
    loading.value = false;
  }

  Future<void> updateProduct(Product updateProduct) async {
    loading.value = true;
    await networkService
        .updateProduct(ProductManagerModel(item: updateProduct))
        .then((value) {
      if (value?.statusCode == 200) {
        DialogCommon().showAlertDialog(
            context: Get.context!,
            title: 'Sửa thành công product ${updateProduct.name}');
        getAllProduct();
      } else {
        DialogCommon()
            .showAlertDialog(context: Get.context!, title: 'Lỗi sửa product');
      }
    });
    loading.value = false;
  }

  Future<void> deleteProduct(Product deleteProduct) async {
    loading.value = true;
    await networkService
        .deleteProduct(ProductManagerModel(item: deleteProduct))
        .then((value) {
      if (value?.statusCode == 200) {
        DialogCommon().showAlertDialog(
            context: Get.context!,
            title: 'Xóa thành công product ${deleteProduct.name}');
        getAllProduct();
      } else {
        DialogCommon()
            .showAlertDialog(context: Get.context!, title: 'Lỗi xóa product');
      }
    });
    loading.value = false;
  }

  // String? get

  void removeProduct(int id) {
    productList.removeWhere((element) => element.id == id);
  }

  // void showAdd(BuildContext context) {
  //   // await getInfomationForProduct();
  //   DialogProduct(viewModel: this).productDialog(context);
  // }
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
