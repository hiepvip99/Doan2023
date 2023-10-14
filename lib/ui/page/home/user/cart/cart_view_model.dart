// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:web_app/model/network/cart_model.dart';
import 'package:web_app/service/network/cart_service.dart';

import '../../../../../model/network/color_model.dart';
import '../../../../../model/network/size_model.dart';
import '../../../../../service/network/color_service.dart';
import '../../../../../service/network/size_service.dart';

class CartViewModel extends GetxController {
  RxList<ProductCartModel> productInCart = RxList();

  CartService cartService = CartService();

  @override
  void onInit() {
    super.onInit();
    getAllProductInCart();
    getInfomationForProduct();
  }

  ColorService colorNetworkService = ColorService();
  SizeService sizeNetworkService = SizeService();

  RxList<Color> colorList = RxList();
  RxList<Size> sizeList = RxList();

  Future<void> getInfomationForProduct() async {
    // manufacturerNetworkService
    //     .getAllManufacturer(step: 1000)
    //     .then((value) => manufacturerList.value = value?.manufacturer ?? []);
    colorNetworkService
        .getAllColor()
        .then((value) => colorList.value = value?.color ?? []);
    sizeNetworkService
        .getAllSize()
        .then((value) => sizeList.value = value?.size ?? []);
    // categoryNetworkService
    //     .getAllCategory(step: 1000)
    //     .then((value) => categoryList.value = value?.category ?? []);
  }

  Future<void> updateProductQuantity(ProductInCart productInCart) async {
    cartService
        .updateCart(productInCart)
        .then((value) => print(value?.statusCode));
  }

  Future<void> getAllProductInCart() async {
    // loading.value = true;
    const accId = 3;
    // final accId = DataLocal.getAccountId() ?? '';
    await cartService.getCartById(accId).then((value) {
      if (value != null) {
        if (value.data != null) {
          productInCart.value = value.data!
              .map((e) => ProductCartModel(productInCart: e))
              .toList();
        }
      }
    });
    // loading.value = false;
  }

  void selectProduct(int index) {
    productInCart[index].isSelected = !productInCart[index].isSelected;
    productInCart.refresh();
  }

  void updateQuantity(int index, int quantity) {
    productInCart[index].productInCart.quantity = quantity;
    productInCart.refresh();
    updateProductQuantity(productInCart[index].productInCart);
  }

  void updateQuantityNoRefesh(int index, int quantity) {
    productInCart[index].productInCart.quantity = quantity;
    updateProductQuantity(productInCart[index].productInCart);
    // productInCart.refresh();
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
}

class ProductCartModel {
  ProductInCart productInCart;
  bool isSelected;
  ProductCartModel({
    required this.productInCart,
    this.isSelected = false,
  });
}