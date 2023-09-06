import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../component_common/close_button.dart';
import '../../../../../../component_common/delete_body_dialog_common.dart';
import '../../../../../../component_common/my_dropdown_button2.dart';
import '../../../../../../component_common/textfield_common.dart';
import '../../../../../../dialog/dialog_common.dart';

class DialogAccount {
  void showDialogAccount(Widget body, String title) {
    Get.find<DialogCommon>().showDialogWithBody(
      title: 'Thêm tài khoản',
      bodyDialog: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          body,
        ],
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
                label: 'Mật khẩu',
                controller: TextEditingController()),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text('Phân quyền'),
                const SizedBox(
                  width: 10,
                ),
                DropDownCustom(
                  initValue: 'Admin',
                  listItem: const ['Admin', 'User'],
                  onChangeDropDown: (value) {},
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text('Trạng thái'),
                const SizedBox(
                  width: 10,
                ),
                DropDownCustom(
                  initValue: 'Active',
                  listItem: const [
                    'Active',
                    'Inactive',
                    'Locked',
                    'Pending',
                    'Closed'
                  ],
                  onChangeDropDown: (value) {},
                ),
              ],
            ),
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

class DropDownCustom extends StatefulWidget {
  const DropDownCustom({
    super.key,
    required this.initValue,
    required this.listItem,
    required this.onChangeDropDown,
  });

  final String initValue;
  final List<String> listItem;
  final Function(String value) onChangeDropDown;

  @override
  State<DropDownCustom> createState() => _DropDownCustomState();
}

class _DropDownCustomState extends State<DropDownCustom> {
  String value = '';

  @override
  void initState() {
    super.initState();
    value = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return MyDropdownButton2StateFull(
      hint: '',
      value: value,
      // itemHeight: 20,
      dropdownItems: widget.listItem,
      onChanged: (valueF) {
        if (valueF != null) {
          // controller.onStepChange(value);
          setState(() {
            value = valueF;
            widget.onChangeDropDown(valueF);
          });
        }
      },
    );
  }
}
