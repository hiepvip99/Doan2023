// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';

import '../../../../../../../service/network/customer_service.dart';

class AddressManagerViewModel extends GetxController {
  RxList<String> addresses = RxList();

  int? customerId;
  CustomerService customerService = CustomerService();

  final dialog = Get.find<DialogCommon>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final data = Get.arguments;
    if (data is AddressManagerViewArg) {
      addresses.value = data.addresses;
      customerId = data.customerId;
    }
  }

  void addAddress(String newAddressTitle) {
    final data = addresses.map((element) => element).toList();
    data.add(newAddressTitle);
    customerService.updateAddress(data, customerId ?? -1).then((value) {
      if (value?.statusCode == 200) {
        addresses.add(newAddressTitle);
        dialog.showAlertDialog(
            context: Get.context!, title: 'Bạn đã thêm địa chỉ mới thành công');
      }
    });
  }

  void deleteAddress(int index) {
    final data = addresses.map((element) => element).toList();
    data.removeAt(index);
    customerService.updateAddress(data, customerId ?? -1).then((value) {
      if (value?.statusCode == 200) {
        addresses.removeAt(index);
        dialog.showAlertDialog(
            context: Get.context!, title: 'Bạn đã xoá địa chỉ thành công');
      }
    });
  }
}

class AddressManagerViewArg {
  final List<String> addresses;
  final int? customerId;
  AddressManagerViewArg({
    required this.addresses,
    required this.customerId,
  });
}
