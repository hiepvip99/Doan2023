// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';

import '../../../../../../model/network/category_model.dart';
import '../../../../../../service/network/category_service.dart';
import '../product_manager/product_manager_view_model.dart';

class CategoryViewModel extends GetxController {
  RxList<Category> categoryList = RxList([]);
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  RxBool loading = false.obs;
  RxString keyword = ''.obs;

  CategoryService networkService = CategoryService();

  final dialog = DialogCommon();

  void onPageChange(int index) {
    currentPage.value = index + 1;
    getCategoryList();
    // print(currentPage.value);
  }

  void onStepChange(String? value) {
    selectedItem.value = value ?? '10';
    currentPage.value = 1;
    getCategoryList();
  }

  @override
  void onInit() {
    super.onInit();
    // categoryList.value = List.generate(
    //     20,
    //     (index) => CategoryModel(
    //         id: index, categorysName: 'categorysName $index'));
    getCategoryList();
  }

  Future<void> getCategoryList() async {
    loading.value = true;
    await networkService
        .getAllCategory(
            currentPage: currentPage.value,
            step: int.tryParse(selectedItem.value) ?? 10,
            keyword: keyword.value)
        .then((value) {
      if (value != null) {
        categoryList.clear();
        categoryList.value = value.category ?? [];
        totalPage.value = value.totalPages ?? 1;
      }
    });
    loading.value = false;
  }

  Future<void> addCategory(
    Category data,
  ) async {
    await networkService
        .addCategory(CategoryManagerModel(categoryObj: data))
        .then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(Get.context!, "Thêm danh mục thành công");
        }
        getCategoryList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }

  Future<void> updateCategory(
    Category data,
  ) async {
    await networkService
        .updateCategory(CategoryManagerModel(categoryObj: data))
        .then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          dialog.showSuccessDialog(Get.context!, "Sửa danh mục thành công");
        }
        getCategoryList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }

  Future<void> deleteCategory(
    Category data,
  ) async {
    await networkService
        .deleteCategory(CategoryManagerModel(categoryObj: data))
        .then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(Get.context!, "Xóa danh mục thành công");
        }
        getCategoryList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }
}

// class CategoryModel {
//   int id;
//   String categorysName;
//   CategoryModel({
//     required this.id,
//     required this.categorysName,
//   });
// }
