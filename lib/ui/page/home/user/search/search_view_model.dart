import 'package:get/get.dart';
import 'package:web_app/model/network/manufacturer_model.dart';

import '../../../../../model/network/category_model.dart';
import '../../../../../model/network/color_model.dart';
import '../../../../../model/network/product_manager_model.dart';
import '../../../../../service/network/category_service.dart';
import '../../../../../service/network/color_service.dart';
import '../../../../../service/network/manufacturer_service.dart';
import '../../../../../service/network/product_service.dart';

class SearchViewModel extends GetxController {
  RxList<Product> productList = RxList();
  RxBool loading = false.obs;
  RxString keyword = ''.obs;
  ProductService networkService = ProductService();
  RxInt currentPage = 1.obs;
  // RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;

  Rx<Manufacturer> manufacturer = Rx(Manufacturer());
  Rx<Color> color = Rx(Color());
  Rx<Category> category = Rx(Category());

  int? minPrice, maxPrice;
  String? gender;
  String? sortBy;

  RxList<Manufacturer> manufacturerList = RxList();
  RxList<Color> colorList = RxList();
  // RxList<Size> sizeList = RxList();
  RxList<Category> categoryList = RxList();

  ManufacturerService manufacturerNetworkService = ManufacturerService();
  ColorService colorNetworkService = ColorService();
  // SizeService sizeNetworkService = SizeService();
  CategoryService categoryNetworkService = CategoryService();

  Future<void> getInfomationForProduct() async {
    manufacturerNetworkService
        .getAllManufacturer(step: 1000)
        .then((value) => manufacturerList.value = value?.manufacturer ?? []);
    colorNetworkService
        .getAllColor()
        .then((value) => colorList.value = value?.color ?? []);
    // sizeNetworkService
    //     .getAllSize()
    //     .then((value) => sizeList.value = value?.size ?? []);
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
            keyword: keyword.value,
            manufacturerId: manufacturer.value.id,
            categoryId: category.value.id,
            minPrice: minPrice,
            maxPrice: maxPrice,
            gender: gender,
            sortBy: sortBy)
        .then((value) {
      productList.clear();
      productList.value = value?.product ?? [];
      // totalPage.value = value?.totalPages ?? 1;
    });
    loading.value = false;
  }

  void removeFilter() {
    manufacturer.value = Manufacturer();
    color.value = Color();
    category.value = Category();
    minPrice = null;
    maxPrice = null;
    gender = null;
    sortBy = null;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInfomationForProduct();
    final data = Get.arguments;
    if (data is Manufacturer) {
      manufacturer.value = data;
    }
  }
}
