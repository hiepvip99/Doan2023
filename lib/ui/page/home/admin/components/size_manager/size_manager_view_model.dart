import 'package:get/get.dart';

import '../../../../../../model/network/size_model.dart';
import '../../../../../../service/network/size_service.dart';
import '../../../../../dialog/dialog_common.dart';
import '../product_manager/product_manager_view_model.dart';

class SizeViewModel extends GetxController {
  RxList<Size> sizeList = RxList([]);
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  RxBool loading = false.obs;
  RxString keyword = ''.obs;

  SizeService networkService = SizeService();

  final dialog = DialogCommon();

  void onPageChange(int index) {
    currentPage.value = index + 1;
    getSizeList();
    print(currentPage.value);
  }

  void onStepChange(String? value) {
    selectedItem.value = value ?? '10';
    currentPage.value = 1;
    getSizeList();
  }

  @override
  void onInit() {
    super.onInit();
    // sizeList.value = List.generate(
    //     20,
    //     (index) => SizesModel(
    //         id: index, sizesName: 'sizesName $index'));
    getSizeList();
  }

  Future<void> getSizeList() async {
    loading.value = true;
    await networkService
        .getAllSize(
            currentPage: currentPage.value,
            step: int.tryParse(selectedItem.value) ?? 10,
            keyword: keyword.value)
        .then((value) {
      if (value != null) {
        sizeList.clear();
        sizeList.value = value.size ?? [];
        totalPage.value = value.totalPages ?? 1;
      }
    });
    loading.value = false;
  }

  Future<void> addSize(
    Size data,
  ) async {
    await networkService.addSize(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(
              Get.context!, "Thêm nhà sản xuất thành công");
        }
        getSizeList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }

  Future<void> updateSize(
    Size data,
  ) async {
    await networkService.updateSize(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          dialog.showSuccessDialog(Get.context!, "Sửa nhà sản xuất thành công");
        }
        getSizeList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }

  Future<void> deleteSize(
    Size data,
  ) async {
    await networkService.deleteSize(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(Get.context!, "Xóa nhà sản xuất thành công");
        }
        getSizeList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }
}

// class SizesModel {
//   int id;
//   String sizesName;
//   SizesModel({
//     required this.id,
//     required this.sizesName,
//   });
// }
