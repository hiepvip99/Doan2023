import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../component_common/textfield_common.dart';

class DialogAccount {
  void showDialogAdd() {
    if (Get.context != null) {
      showDialog(
        context: Get.context!,
        builder: (context) => Container(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
          child: Column(
            children: [
              TextFieldCommon(
                  requiredInput: true,
                  label: 'Tên Tài khoản',
                  controller: TextEditingController()),
              TextFieldCommon(
                  requiredInput: true,
                  label: 'Họ và tên',
                  controller: TextEditingController()),
              TextFieldCommon(
                  requiredInput: true,
                  label: 'Email',
                  controller: TextEditingController()),
              TextFieldCommon(
                  requiredInput: true,
                  label: 'Role đang làm ? Phân quuyền',
                  controller: TextEditingController()),
            ],
          ),
        ),
      );
    }
  }
}
