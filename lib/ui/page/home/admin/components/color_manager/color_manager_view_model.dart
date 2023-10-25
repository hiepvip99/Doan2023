import 'package:get/get.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';

import '../../../../../../model/network/color_model.dart';
import '../../../../../../service/network/color_service.dart';
import '../product_manager/product_manager_view_model.dart';

class ColorViewModel extends GetxController {
  RxList<ColorShoe> colorList = RxList([]);
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  RxBool loading = false.obs;
  RxString keyword = ''.obs;

  ColorService networkService = ColorService();

  final dialog = DialogCommon();

  void onPageChange(int index) {
    currentPage.value = index + 1;
    getColorList();
    print(currentPage.value);
  }

  void onStepChange(String? value) {
    selectedItem.value = value ?? '10';
    currentPage.value = 1;
    getColorList();
  }

  @override
  void onInit() {
    super.onInit();
    // colorList.value = List.generate(
    //     20,
    //     (index) => ColorsModel(
    //         id: index, colorsName: 'colorsName $index'));
    getColorList();
  }

  Future<void> getColorList() async {
    loading.value = true;
    await networkService
        .getAllColor(
            currentPage: currentPage.value,
            step: int.tryParse(selectedItem.value) ?? 10,
            keyword: keyword.value)
        .then((value) {
      if (value != null) {
        colorList.clear();
        colorList.value = value.color ?? [];
        totalPage.value = value.totalPages ?? 1;
      }
    });
    loading.value = false;
  }

  Future<void> addColor(
    ColorShoe data,
  ) async {
    await networkService.addColor(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(
              Get.context!, "Thêm màu sắc thành công");
        }
        getColorList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }

  Future<void> updateColor(
    ColorShoe data,
  ) async {
    await networkService.updateColor(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          dialog.showSuccessDialog(Get.context!, "Sửa màu sắc thành công");
        }
        getColorList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }

  Future<void> deleteColor(
    ColorShoe data,
  ) async {
    await networkService.deleteColor(data).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(Get.context!, "Xóa màu sắc thành công");
        }
        getColorList();
        Get.find<ProductManagerViewModel>().getInfomationForProduct();
      }
    });
  }
}

// class ColorsModel {
//   int id;
//   String colorsName;
//   ColorsModel({
//     required this.id,
//     required this.colorsName,
//   });
// }
