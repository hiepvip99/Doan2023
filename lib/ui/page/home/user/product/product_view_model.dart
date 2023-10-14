import 'package:get/get.dart';
import 'package:web_app/model/network/cart_model.dart';
import 'package:web_app/model/network/product_manager_model.dart';

import '../../../../../model/network/color_model.dart';
import '../../../../../model/network/size_model.dart';
import '../../../../../service/network/cart_service.dart';
import '../../../../../service/network/color_service.dart';
import '../../../../../service/network/manufacturer_service.dart';
import '../../../../../service/network/size_service.dart';
import '../../../../dialog/dialog_common.dart';

class ProductViewModel extends GetxController {
  RxBool favorite = false.obs;

  RxList<int?> sizeOfProduct = RxList();
  CartService cartService = CartService();
  // ManufacturerService manufacturerNetworkService = ManufacturerService();
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

  Future<void> addToCart(ProductInCart productView) async {
    const accId = 3;
    cartService
        .addCart(ProductInCart(
            accountId: accId,
            // id: ,
            productId: product.id,
            colorId: productView.colorId,
            sizeId: productView.sizeId,
            quantity: productView.quantity))
        .then((value) {
      if (value?.statusCode == 200) {
        Get.find<DialogCommon>().showAlertDialog(
            context: Get.context!, title: 'Thêm vào giỏ hàng thành công');
      }
    });
  }

  Product product = Product();
  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments;
    if (data is Product) {
      product = data;
      if (product.sizes != null) {
        for (var element in product.sizes!) {
          final indexExist = sizeOfProduct.indexOf(element.sizeId);
          if (indexExist == -1) {
            sizeOfProduct.add(element.sizeId);
          }
        }
      }
    }
    getInfomationForProduct();
  }
}

// class ProductViewArgument{
//   Product
// }