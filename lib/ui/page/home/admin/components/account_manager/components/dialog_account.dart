import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../component_common/delete_body_dialog_common.dart';
import '../../../../../../component_common/textfield_common.dart';
import '../../../../../../dialog/dialog_common.dart';

class DialogAccount {
  void showDialogAccount(Widget body, String title) {
    Get.find<DialogCommon>().showDialogWithBody(
      bodyDialog: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 400),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.clear,
                          ),
                        ),
                        onTap: () => Get.back(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  body,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showDialogAdd() {
    showDialogAccount(
        Column(
          children: [
            TextFieldCommon(
                requiredInput: true,
                label: 'Tên Tài khoản',
                controller: TextEditingController()),
            const SizedBox(
              height: 16,
            ),
            TextFieldCommon(
                requiredInput: true,
                label: 'Họ và tên',
                controller: TextEditingController()),
            const SizedBox(
              height: 16,
            ),
            TextFieldCommon(
                requiredInput: true,
                label: 'Email',
                controller: TextEditingController()),
            const SizedBox(
              height: 16,
            ),
            TextFieldCommon(
                requiredInput: true,
                label: 'Role đang làm ? Phân quuyền',
                controller: TextEditingController()),
          ],
        ),
        'Thêm tài khoản');
  }

  void showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteItemDialog(
          itemName: 'Item 1',
          onDelete: () {
            // Xử lý xóa item ở đây
            Navigator.of(context).pop(); // Đóng dialog sau khi xóa
          },
        );
      },
    );
  }
}
