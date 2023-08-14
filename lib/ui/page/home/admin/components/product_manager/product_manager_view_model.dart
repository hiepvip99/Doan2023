// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/page/home/admin/components/product_manager/components/dialog_product.dart';

class ProductManagerViewModel extends GetxController {
  RxList<ProductModel> productList = RxList([]);
  Rx<ProductModel> itemAdd = Rx(ProductModel());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    productList.value = [
      ProductModel(
          id: 0,
          image:
              'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/503e9eea-02dd-4f8f-91e3-6ad74a9225cc/quest-5-road-running-shoes-8wZR01.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
      ProductModel(
          id: 1,
          image:
              'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9989cd60-470b-4c37-b61c-d94a019819ce/freak-4-basketball-shoes-zmXv3D.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
      ProductModel(
          id: 2,
          image:
              'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e6da41fa-1be4-4ce5-b89c-22be4f1f02d4/air-force-1-07-shoes-WrLlWX.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
      ProductModel(
          id: 3,
          image:
              'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/503e9eea-02dd-4f8f-91e3-6ad74a9225cc/quest-5-road-running-shoes-8wZR01.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
      ProductModel(
          id: 4,
          image:
              'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9989cd60-470b-4c37-b61c-d94a019819ce/freak-4-basketball-shoes-zmXv3D.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
      ProductModel(
          id: 5,
          image:
              'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e6da41fa-1be4-4ce5-b89c-22be4f1f02d4/air-force-1-07-shoes-WrLlWX.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
      ProductModel(
          id: 6,
          image:
              'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/503e9eea-02dd-4f8f-91e3-6ad74a9225cc/quest-5-road-running-shoes-8wZR01.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
      ProductModel(
          id: 7,
          image:
              'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9989cd60-470b-4c37-b61c-d94a019819ce/freak-4-basketball-shoes-zmXv3D.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
      ProductModel(
          id: 8,
          image:
              'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e6da41fa-1be4-4ce5-b89c-22be4f1f02d4/air-force-1-07-shoes-WrLlWX.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
      ProductModel(
          id: 9,
          image:
              'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/503e9eea-02dd-4f8f-91e3-6ad74a9225cc/quest-5-road-running-shoes-8wZR01.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
      ProductModel(
          id: 10,
          image:
              'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9989cd60-470b-4c37-b61c-d94a019819ce/freak-4-basketball-shoes-zmXv3D.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
      ProductModel(
          id: 11,
          image:
              'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e6da41fa-1be4-4ce5-b89c-22be4f1f02d4/air-force-1-07-shoes-WrLlWX.png',
          name: 'Giầy thể thao',
          price: 10000000,
          manufacturerId: 0,
          gender: 'Nam',
          quatity: 99,
          colorId: [0, 1]),
    ];
  }

  void removeProduct(int id) {
    productList.removeWhere((element) => element.id == id);
  }

  void showDelete(int id, BuildContext context) {
    DialogProduct(viewModel: this)
        .showDeleteConfirmation(context, id, () => removeProduct(id));
  }

  void showAdd(BuildContext context) {
    DialogProduct(viewModel: this).addProductDialog(context, itemAdd);
  }
}

class ProductModel {
  int? id;
  String? image;
  String? name;
  int? price;
  int? manufacturerId;
  String? gender;
  int? quatity;
  List<int>? colorId;
  ProductModel({
    this.id,
    this.image,
    this.name,
    this.price,
    this.manufacturerId,
    this.gender,
    this.quatity,
    this.colorId,
  });
}

// class Product
