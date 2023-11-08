import 'package:get/get.dart';
import 'package:web_app/model/network/customer_model.dart';
import 'package:web_app/service/network/customer_service.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';
import 'package:web_app/ui/page/home/user/home_user.dart';
import 'package:web_app/ui/page/home/user/profile/my_profile/my_profile_view_model.dart';

import '../../../../model/network/manufacturer_model.dart';
import '../../../../model/network/product_manager_model.dart';
import '../../../../service/local/save_data.dart';
import '../../../../service/network/manufacturer_service.dart';
import '../../../../service/network/product_service.dart';
import 'profile/my_profile/my_profile_view.dart';

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
  CustomerService customerService = CustomerService();

  RxList<Product> productList = RxList();
  RxList<Product> productListMen = RxList();
  RxList<Product> productListWomen = RxList();
  // RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;

  ManufacturerService manufacturerNetworkService = ManufacturerService();
  // ColorService colorNetworkService = ColorService();
  // SizeService sizeNetworkService = SizeService();
  // CategoryService categoryNetworkService = CategoryService();

  final accountId = DataLocal.getAccountId();
  Customer customer = Customer();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInfomationForProduct();
    getFourShoeWomen();
    getFourShoeMen();
  }

  Future<void> checkCustomer() async {
    customerService.checkInfoCustomer(accountId: accountId).then((value) async {
      if (value?.hasUpdateInfomation == true) {
        await customerService
            .getCustomerById(accountId: accountId)
            .then((value) async {
          if (value != null) customer = value;
          await DialogCommon().showAlertDialog(
              context: Get.context!,
              title: 'Bạn chưa điền đầy đủ thông tin (sdt, tên hoặc địa chỉ)');
          Get.offAllNamed(EditProfileScreen.route,
              arguments: ProfileArg(
                  customer: customer, routeSaveAndToNamed: HomeUser.route));
        });
      }
    });
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

  Future<void> getFourShoeMen() async {
    loading.value = true;
    await networkService
        .getAllProduct(
            currentPage: 1, step: 4, keyword: keyword.value, gender: 'Nam')
        .then((value) {
      productListMen.value = value?.product ?? [];
      // totalPage.value = value?.totalPages ?? 1;
    });
    loading.value = false;
  }

  Future<void> getFourShoeWomen() async {
    loading.value = true;
    await networkService
        .getAllProduct(
            currentPage: 1, step: 4, keyword: keyword.value, gender: 'Nữ')
        .then((value) {
      productListWomen.value = value?.product ?? [];
      // totalPage.value = value?.totalPages ?? 1;
    });
    loading.value = false;
  }

  void changeIndex() {
    index.value = 2;
  }
}
