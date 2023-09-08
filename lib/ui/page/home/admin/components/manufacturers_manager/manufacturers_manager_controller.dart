// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';

import '../../../../../../model/network/manufacturer_model.dart';
import '../../../../../../service/network/manufacturer_service.dart';

class ManufacturersViewModel extends GetxController {
  RxList<Manufacturer> manufacturerList = RxList([]);
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  RxBool loading = false.obs;
  RxString keyword = ''.obs;

  ManufacturerService networkService = ManufacturerService();

  final dialog = Get.find<DialogCommon>();

  void onPageChange(int index) {
    currentPage.value = index + 1;
    getManufacturerList();
    print(currentPage.value);
  }

  void onStepChange(String? value) {
    selectedItem.value = value ?? '10';
    currentPage.value = 1;
    getManufacturerList();
  }

  @override
  void onInit() {
    super.onInit();
    // manufacturerList.value = List.generate(
    //     20,
    //     (index) => ManufacturersModel(
    //         id: index, manufacturersName: 'manufacturersName $index'));
    getManufacturerList();
  }

  Future<void> getManufacturerList() async {
    loading.value = true;
    await networkService
        .getAllManufacturer(
            currentPage: currentPage.value,
            step: int.tryParse(selectedItem.value) ?? 10,
            keyword: keyword.value)
        .then((value) {
      if (value != null) {
        manufacturerList.clear();
        manufacturerList.value = value.manufacturer ?? [];
        totalPage.value = value.totalPages ?? 1;
      }
    });
    loading.value = false;
  }

  Future<void> addManufacturer(
    Manufacturer data,
  ) async {
    loading.value = true;
    await networkService
        .addManufacturer(ManufacturerManagerModel(manufacturerObj: data))
        .then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(
              Get.context!, "Thêm nhà sản xuất thành công");
        }
        getManufacturerList();
      }
    });
    loading.value = false;
  }

  Future<void> updateManufacturer(
    Manufacturer data,
  ) async {
    loading.value = true;
    await networkService
        .updateManufacturer(ManufacturerManagerModel(manufacturerObj: data))
        .then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          dialog.showSuccessDialog(Get.context!, "Sửa nhà sản xuất thành công");
        }
        getManufacturerList();
      }
    });
    loading.value = false;
  }

  Future<void> deleteManufacturer(
    Manufacturer data,
  ) async {
    loading.value = true;
    await networkService
        .deleteManufacturer(ManufacturerManagerModel(manufacturerObj: data))
        .then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          dialog.showSuccessDialog(Get.context!, "Xóa nhà sản xuất thành công");
        }
        getManufacturerList();
      }
    });
    loading.value = false;
  }
}

// class ManufacturersModel {
//   int id;
//   String manufacturersName;
//   ManufacturersModel({
//     required this.id,
//     required this.manufacturersName,
//   });
// }
