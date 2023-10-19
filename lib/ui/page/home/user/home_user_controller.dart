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
  RxInt currentPage = 1.obs;
  RxString keyword = ''.obs;
  RxBool loading = false.obs;

  RxInt index = 0.obs;

  RxList<Manufacturer> manufacturerList = RxList();
  // RxList<Color> colorList = RxList();
  // RxList<Size> sizeList = RxList();
  // RxList<Category> categoryList = RxList();

  ProductService networkService = ProductService();

  RxList<Product> productList = RxList();
  // RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;

  ManufacturerService manufacturerNetworkService = ManufacturerService();
  // ColorService colorNetworkService = ColorService();
  // SizeService sizeNetworkService = SizeService();
  // CategoryService categoryNetworkService = CategoryService();

  @override
  void onInit() {
    // TODO: implement onInit
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

  void changeIndex() {
    index.value = 2;
  }
}
