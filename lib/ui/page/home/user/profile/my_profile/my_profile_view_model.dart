// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:web_app/model/network/product_manager_model.dart';
import 'package:web_app/service/local/save_data.dart';

import '../../../../../../model/network/customer_model.dart';
import '../../../../../../service/network/customer_service.dart';
import '../../../../../dialog/dialog_common.dart';
import '../profile_view_model.dart';

class EditProfileViewModel extends GetxController {
  Rx<Customer> customerInfo = Rx(Customer());
  CustomerService customerService = CustomerService();
  final dialog = DialogCommon();
  String? accountId = DataLocal.getAccountId();
  String routeSaveAndToNamed = '';

  Future<void> updateInfomation() async {
    await customerService
        .updateCustomerInfo(customerInfo.value)
        .then((value) async {
      if (value?.statusCode == 200) {
        Get.find<ProfileViewModel>().getInfomationCustomer();
        if (routeSaveAndToNamed.trim().isNotEmpty) {
          dialog
              .showAlertDialog(
                  context: Get.context!,
                  title: 'Bạn đã cập nhật thông tin thành công thành công')
              .then((value) {});
        }
        customerService.checkInfoCustomer(accountId: accountId).then((value) {
          if (value?.hasUpdateInfomation == false) {
            toScreen();
          }
        });
        // Get.showSnackbar(const GetSnackBar(
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.black,
        //   message: '',
        //   title: 'Bạn đã cập nhật thông tin thành công thành công',
        //   duration: Duration(seconds: 2),
        // ));
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

  void toScreen() {
    if (routeSaveAndToNamed.trim().isNotEmpty) {
      Get.offAllNamed(routeSaveAndToNamed);
    }
  }

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments;
    if (data is ProfileArg) {
      customerInfo.value = data.customer;
      routeSaveAndToNamed = data.routeSaveAndToNamed;
    }
  }
}

class ProfileArg {
  Customer customer;
  String routeSaveAndToNamed;
  ProfileArg({
    required this.customer,
    this.routeSaveAndToNamed = '',
  });
}
