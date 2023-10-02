import 'package:get/get.dart';

import '../../../../model/network/color_model.dart';
import '../../../../model/network/manufacturer_model.dart';
import '../../../../model/network/product_manager_model.dart';
import '../../../../model/network/size_model.dart';
import '../../../../service/network/color_service.dart';
import '../../../../service/network/manufacturer_service.dart';
import '../../../../service/network/product_service.dart';
import '../../../../service/network/size_service.dart';

// import '../../../../model/network/order_manager_model.dart';

class HomeUserController extends GetxController {
  RxList<Product> productList = RxList();
  RxInt currentPage = 1.obs;
  // RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  RxBool loading = false.obs;
  RxString keyword = ''.obs;

  RxList<Manufacturer> manufacturerList = RxList();
  // RxList<Color> colorList = RxList();
  // RxList<Size> sizeList = RxList();
  // RxList<Category> categoryList = RxList();

  ProductService networkService = ProductService();
  ManufacturerService manufacturerNetworkService = ManufacturerService();
  // ColorService colorNetworkService = ColorService();
  // SizeService sizeNetworkService = SizeService();
  // CategoryService categoryNetworkService = CategoryService();

  @override
  void onInit() {
    super.onInit();
    getInfomationForProduct();
  }

  Future<void> getInfomationForProduct() async {
    manufacturerNetworkService
        .getAllManufacturer(step: 1000)
        .then((value) => manufacturerList.value = value?.manufacturer ?? []);
    // colorNetworkService
    //     .getAllColor()
    //     .then((value) => colorList.value = value?.color ?? []);
    // sizeNetworkService
    //     .getAllSize()
    //     .then((value) => sizeList.value = value?.size ?? []);
    // categoryNetworkService
    //     .getAllCategory(step: 1000)
    //     .then((value) => categoryList.value = value?.category ?? []);
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
      // totalPage.value = value?.totalPages ?? 1;
    });
    loading.value = false;
  }
}
