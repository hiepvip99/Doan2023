// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class ManufacturersManagerController extends GetxController {
  RxList<ManufacturersModel> listmanufacturers = RxList([]);

  RxInt currentPage = 1.obs;
  RxInt totalPage = 10.obs;
  RxString selectedItem = '10'.obs;

  void onPageChange(int index) {
    currentPage.value = index + 1;
    print(currentPage.value);
  }

  void onStepChange(String? value) {
    selectedItem.value = value ?? '10';
    currentPage.value = 1;
  }
  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listmanufacturers.value = List.generate(
        20,
        (index) => ManufacturersModel(
            id: index, manufacturersName: 'manufacturersName $index'));
  }
}

class ManufacturersModel {
  int id;
  String manufacturersName;
  ManufacturersModel({
    required this.id,
    required this.manufacturersName,
  });
}
