import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/model/network/account_model.dart';

import '../../../../../../component_common/close_button.dart';
import '../../../../../../component_common/delete_body_dialog_common.dart';
import '../../../../../../component_common/my_dropdown_button2.dart';
import '../../../../../../component_common/textfield_common.dart';
import '../../../../../../dialog/dialog_common.dart';
import '../account_manager_controller.dart';

class DialogAccount {
  final AccountManagerViewModel viewModel = Get.find<AccountManagerViewModel>();
  void showDialogAccount(Widget body, String title) {
    Get.find<DialogCommon>().showDialogWithBody(
      title: title /*  'Thêm tài khoản' */,
      bodyDialog: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
    AccountInfo accountRegister = AccountInfo();
    TextEditingController txtUsername = TextEditingController();
    TextEditingController txtPassword = TextEditingController();
    showDialogAccount(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tên Tài khoản'),
            const SizedBox(
              height: 16,
            ),
            TextFieldCommon(controller: txtUsername),
            const SizedBox(
              height: 16,
            ),
            const Text('Mật khẩu'),
            const SizedBox(
              height: 16,
            ),
            TextFieldCommon(isTextPassword: true, controller: txtPassword),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const SizedBox(width: 100, child: Text('Phân quyền')),
                const SizedBox(
                  width: 10,
                ),
                DropDownCustom(
                  initValue: viewModel.decentralizationList
                      .map((element) => element.name ?? "")
                      .toList()
                      .first,
                  listItem: viewModel.decentralizationList
                      .map((element) => element.name ?? "")
                      .toList(),
                  onChangeDropDown: (value) {
                    final int index = viewModel.decentralizationList
                        .indexWhere((element) => element.name == value);
                    if (index != -1) {
                      accountRegister.decentralizationId =
                          viewModel.decentralizationList[index].id;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const SizedBox(width: 100, child: Text('Trạng thái')),
                const SizedBox(
                  width: 10,
                ),
                DropDownCustom(
                  initValue: viewModel.accountStatusList
                      .map((element) => element.name ?? "")
                      .toList()
                      .first,
                  listItem: viewModel.accountStatusList
                      .map((element) => element.name ?? "")
                      .toList(),
                  onChangeDropDown: (value) {
                    final int index = viewModel.accountStatusList
                        .indexWhere((element) => element.name == value);
                    if (index != -1) {
                      accountRegister.statusId =
                          viewModel.accountStatusList[index].id;
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      print(
                          "accountRegister.decentralizationId = ${accountRegister.decentralizationId}");
                      print(
                          "accountRegister.statusId = ${accountRegister.statusId}");
                    },
                    child: const Text('Submit')),
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
