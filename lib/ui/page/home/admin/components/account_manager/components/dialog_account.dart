import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

class DeleteItemDialog extends StatelessWidget {
  final String itemName;
  final VoidCallback onDelete;

  const DeleteItemDialog({
    super.key,
    required this.itemName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xóa $itemName?'),
      content: Text('Bạn có chắc muốn xóa $itemName không?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Đóng Dialog
          },
          child: Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: onDelete,
          child: Text('Xóa'),
        ),
      ],
    );
  }
}
