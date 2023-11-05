import 'package:get/get.dart';
import 'package:web_app/model/network/cart_model.dart';
import 'package:web_app/model/network/order_manager_model.dart';
import 'package:web_app/model/network/product_manager_model.dart';
import 'package:web_app/service/network/order_service.dart';

import '../../../../../model/network/color_model.dart';
import '../../../../../model/network/size_model.dart';
import '../../../../../service/local/save_data.dart';
import '../../../../../service/network/cart_service.dart';
import '../../../../../service/network/color_service.dart';
import '../../../../../service/network/manufacturer_service.dart';
import '../../../../../service/network/product_service.dart';
import '../../../../../service/network/size_service.dart';
import '../../../../dialog/dialog_common.dart';
import '../favorite/favorite_view_model.dart';

class ProductViewModel extends GetxController {
  RxBool favorite = false.obs;
  RxInt ratingSearch = 0.obs;
  RxInt currentPage = 1.obs;
  int step = 10;

  Rx<RatingCounts> ratingCounts = Rx(RatingCounts());

  RxList<Review> reviewList = RxList();
  RxDouble averageRating = RxDouble(5);
  RxInt totalRating = 1.obs;

  RxList<int?> sizeOfProduct = RxList();
  CartService cartService = CartService();
  OrderService orderService = OrderService();
  ProductService networkService = ProductService();
  // ManufacturerService manufacturerNetworkService = ManufacturerService();
  ColorService colorNetworkService = ColorService();
  SizeService sizeNetworkService = SizeService();
  RxList<ColorShoe> colorList = RxList();
  RxList<Size> sizeList = RxList();
  Product product = Product();

  final accountId = DataLocal.getAccountId();

  final dialog = DialogCommon();

  Future<void> getInfomationForProduct() async {
    // manufacturerNetworkService
    //     .getAllManufacturer(step: 1000)
    //     .then((value) => manufacturerList.value = value?.manufacturer ?? []);
    await colorNetworkService
        .getAllColor()
        .then((value) => colorList.value = value?.color ?? []);
    await sizeNetworkService
        .getAllSize()
        .then((value) => sizeList.value = value?.size ?? []);
    // categoryNetworkService
    //     .getAllCategory(step: 1000)
    //     .then((value) => categoryList.value = value?.category ?? []);
  }

  Future<void> checkFavorite() async {
    await networkService
        .checkFavorite(Favorite(accountId: accountId, productId: product.id))
        .then((value) {
      favorite.value = value?.isFavorite ?? false;
    });
  }

  Future<void> addToFavorite() async {
    await networkService
        .addFavorite(Favorite(accountId: accountId, productId: product.id));
    // Get.find<FavoriteViewModel>().getAllFavoriteProduct();
  }

  Future<void> removeFavorite() async {
    await networkService.removeFavorite(
        [Favorite(accountId: accountId, productId: product.id)]).then((value) {
      // print('status: ${value?.statusCode}');
    });
    // Get.find<FavoriteViewModel>().getAllFavoriteProduct();
  }

  Future<void> getAllReview() async {
    await orderService
        .getAllReview(
            productId: product.id,
            rating: ratingSearch.value != 0 ? ratingSearch.value : null,
            page: currentPage.value,
            step: step)
        .then((value) {
      reviewList.value = value?.reviews ?? [];
      averageRating.value = value?.averageRating ?? 5.0;
      totalRating.value = value?.totalRating ?? 1;
      if (totalRating.value < 1) {
        totalRating.value = 1;
      }
      ratingCounts.value = value?.ratingCounts ?? RatingCounts();
    });
  }

  Future<void> addToCart(ProductInCart productView) async {
    await cartService
        .addCart(ProductInCart(
            accountId: accountId,
            // id: ,
            productId: product.id,
            colorId: productView.colorId,
            sizeId: productView.sizeId,
            quantity: productView.quantity))
        .then((value) {
      if (value?.statusCode == 200) {
        DialogCommon().showAlertDialog(
            context: Get.context!, title: 'Thêm vào giỏ hàng thành công');
      }
    });
  }

  @override
  void onInit() {
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
    super.onInit();
    getInfomationForProduct();
    checkFavorite();
    getAllReview();
  }
}

// class ProductViewArgument{
//   Product
// }