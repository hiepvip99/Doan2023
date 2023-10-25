import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:web_app/model/network/login_model.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';
import 'package:web_app/ui/page/home/admin/home_admin_view.dart';

import '../../../service/local/save_data.dart';
import '../../../service/network/login_service.dart';
import '../home/home.dart';
import '../home/user/home_user.dart';
import 'login_view.dart';

class LoginController extends GetxController {
  LoginService loginService = LoginService();
  RxBool statusLogin = false.obs;
  RxBool isRoleAdmin = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await checkStatusAndRoleLogin();
  }

  Future<void> checkStatusAndRoleLogin() async {
    final accountId = DataLocal.getAccountId();
    final role = DataLocal.getRole();
    if (accountId != '') {
      statusLogin.value = true;
      // -1 chua login
      // 0 admin
      // 1 user
      if (role != null) {
        if (role == 0) {
          isRoleAdmin.value = true;
        } else {
          isRoleAdmin.value = false;
        }
      }
    } else {
      statusLogin.value = false;
    }
  }

  Future<void> loginApp(String userName, String password) async {
    // DialogCommon.instance.showLoadingDialog();
    await loginService
        .loginApp(LoginModel(username: userName, password: password))
        .then((value) async {
      // -1 chua login
      // 0 admin
      // 1 user
      print(value.toString());
      await DataLocal.saveRole(value?.role ?? -1);
      await DataLocal.saveAccountId(value?.account_id ?? '');
      final accId = DataLocal.getAccountId() ?? '';
      final role = DataLocal.getRole() ?? -1;
      if (kDebugMode) {
        print('account id: $accId');
        print('role : $role');
      }
      if (value != null) {
        if (accId.trim().isNotEmpty && role > -1) {
          if (role == 0) {
            Get.offNamed(HomeAdmin.route);
          } else {
            Get.offNamed(HomeUser.route);
          }
        } else {
          if (value.validations != null) {
            String errorMsg = '';
            for (var element in value.validations!) {
              errorMsg += element.message;
            }
            Get.showSnackbar(GetSnackBar(
              backgroundColor: Colors.black,
              message: errorMsg,
              title: 'Lỗi',
              duration: const Duration(seconds: 3),
            ));
          } else {
            Get.showSnackbar(const GetSnackBar(
              backgroundColor: Colors.black,
              message: 'Không thể lấy thông tin người dùng',
              title: 'Lỗi',
              duration: Duration(seconds: 3),
            ));
          }
        }
      } else {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.black,
          message: 'Sever không phản hồi',
          title: 'Lỗi',
          duration: Duration(seconds: 3),
        ));
      }
    });
    // DialogCommon.instance.dismiss();
    await checkStatusAndRoleLogin();
  }

  Future<void> logoutApp() async {
    await DataLocal.deleteAccount();
    await checkStatusAndRoleLogin();
    Get.offAllNamed(Login.route);
  }
}
