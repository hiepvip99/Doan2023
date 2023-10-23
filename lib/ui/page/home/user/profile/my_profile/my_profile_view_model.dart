import 'dart:io';

import 'package:get/get.dart';
import 'package:web_app/model/network/product_manager_model.dart';

import '../../../../../../model/network/customer_model.dart';
import '../../../../../../service/network/customer_service.dart';
import '../../../../../dialog/dialog_common.dart';
import '../profile_view_model.dart';

class EditProfileViewModel extends GetxController {
  Rx<Customer> customerInfo = Rx(Customer());
  CustomerService customerService = CustomerService();
  final dialog = DialogCommon();
  static const accid = 3;

  Future<void> updateInfomation() async {
    customerService.updateCustomerInfo(customerInfo.value).then((value) {
      if (value?.statusCode == 200) {
        Get.find<ProfileViewModel>().getInfomationCustomer();
        dialog.showAlertDialog(
            context: Get.context!,
            title: 'Bạn đã cập nhật thông tin thành công thành công');
      }
    });
  }

  Future<void> uploadImage(List<File> image) async {
    customerService
        .uploadImages(
            Images(listImageUpload: image, customerId: customerInfo.value.id))
        .then((value) {
      if (value?.statusCode == 200) {
        customerInfo.value.image = value?.url;
        customerInfo.refresh();
        Get.find<ProfileViewModel>().getInfomationCustomer();
        // dialog.showAlertDialog(
        //     context: Get.context!,
        //     title: 'Bạn đã cập nhật thông tin thành công thành công');
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final data = Get.arguments;
    if (data is Customer) {
      customerInfo.value = data;
    }
  }
}
