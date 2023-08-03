// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class ManufacturersManagerController extends GetxController {
  RxList<ManufacturersModel> listmanufacturers = RxList([]);
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
