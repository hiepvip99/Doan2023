import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/model/network/account_model.dart';

import '../../../../../../component_common/close_button.dart';
import '../../../../../../component_common/delete_body_dialog_common.dart';
import '../../../../../../component_common/input_text_with_title.dart';
import '../../../../../../component_common/my_dropdown_button2.dart';
import '../../../../../../component_common/textfield_common.dart';
import '../../../../../../dialog/dialog_common.dart';
import '../account_manager_controller.dart';

class DialogAccount {
  final AccountManagerViewModel viewModel = Get.find<AccountManagerViewModel>();
  void showDialogAccount(Widget body, String title, BuildContext context) {
    Get.find<DialogCommon>().showDialogWithBody(
      context,
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

  String? validateUserName(String value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập username';
    }
    if (!isAlphanumeric(value) || value.contains(' ')) {
      return 'Username chỉ được chứa chữ cái và số, không có khoảng trắng';
    }
    if (!isLength(value, 8, 20)) {
      return 'Username phải có độ dài từ 8 đến 20 ký tự';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (!isLength(value, 8, 20)) {
      return 'Mật khẩu phải có độ dài từ 8 đến 20 ký tự';
    }
    return null;
  }

  bool isLength(String value, int min, int max) {
    final length = value.length;
    return length >= min && length <= max;
  }

  bool isAlphanumeric(String value) {
    final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return alphanumericRegex.hasMatch(value);
  }

  void showDialogAdd(BuildContext context) {
    AccountInfo accountRegister =
        AccountInfo(decentralizationId: 1, statusId: 1);
    TextEditingController txtUsername = TextEditingController();
    TextEditingController txtPassword = TextEditingController();
    TextEditingController txtConfirmPassword = TextEditingController();

    final _formKey = GlobalKey<FormState>();
    showDialogAccount(
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tên tài khoản'),
                const SizedBox(
                  height: 16,
                ),
                TextFieldCommon(
                  controller: txtUsername,
                  validator: (value) {
                    return validateUserName(value ?? '');
                  },
                ),
                // InputTextWithTitle(
                //     textEditingController: txtUsername, title: 'Tên tài khoản'),
                const Text('Mật khẩu'),
                const SizedBox(
                  height: 16,
                ),
                TextFieldCommon(
                  isTextPassword: true,
                  controller: txtPassword,
                  validator: (value) {
                    return validatePassword(value ?? '');
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text('Nhập Lại Mật khẩu'),
                const SizedBox(
                  height: 16,
                ),
                TextFieldCommon(
                  isTextPassword: true,
                  controller: txtConfirmPassword,
                  validator: (value) {
                    validatePassword(value ?? '');
                  },
                ),
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
                          if (_formKey.currentState!.validate()) {
                            accountRegister.username = txtUsername.text.trim();
                            accountRegister.password = txtPassword.text.trim();
                            viewModel.addAccount(accountRegister, context);
                          }

                          // print(
                          //     "accountRegister.decentralizationId = ${accountRegister.decentralizationId}");
                          // print(
                          //     "accountRegister.statusId = ${accountRegister.statusId}");
                        },
                        child: const Text('Submit')),
                  ],
                ),
              ],
            ),
          ),
        ),
        'Thêm tài khoản',
        context);
  }

  void showDialogUpdate(BuildContext context, AccountInfo accUpdate) {
    AccountInfo account = accUpdate;
    TextEditingController txtUsername =
        TextEditingController(text: account.username);
    TextEditingController txtPassword = TextEditingController();
    TextEditingController txtConfirmPassword = TextEditingController();

    final _formKey = GlobalKey<FormState>();
    showDialogAccount(
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Mật khẩu'),
                const SizedBox(
                  height: 16,
                ),
                TextFieldCommon(
                  isTextPassword: true,
                  controller: txtPassword,
                  // validator: (value) {
                  //   return validatePassword(value ?? '');
                  // },
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text('Nhập Lại Mật khẩu'),
                const SizedBox(
                  height: 16,
                ),
                TextFieldCommon(
                  isTextPassword: true,
                  controller: txtConfirmPassword,
                  validator: (value) {
                    if (value != txtPassword.text) {
                      return "Mật khẩu không khớp";
                    }
                    // validatePassword(value ?? '');
                  },
                ),
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
                              .where((value) =>
                                  value.id == account.decentralizationId)
                              .toList()[0]
                              .name ??
                          (viewModel.decentralizationList.first.name ?? ""),
                      listItem: viewModel.decentralizationList
                          .map((element) => element.name ?? "")
                          .toList(),
                      onChangeDropDown: (value) {
                        final int index = viewModel.decentralizationList
                            .indexWhere((element) => element.name == value);
                        if (index != -1) {
                          account.decentralizationId =
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
                              .where((value) => value.id == account.statusId)
                              .toList()[0]
                              .name ??
                          (viewModel.accountStatusList.first.name ??
                              "") /* viewModel.accountStatusList
                          .map((element) => element.name ?? "")
                          .toList()
                          .first */
                      ,
                      listItem: viewModel.accountStatusList
                          .map((element) => element.name ?? "")
                          .toList(),
                      onChangeDropDown: (value) {
                        final int index = viewModel.accountStatusList
                            .indexWhere((element) => element.name == value);
                        if (index != -1) {
                          account.statusId =
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
                          if (_formKey.currentState!.validate()) {
                            account.username = txtUsername.text.trim();
                            account.password = txtPassword.text.trim();
                            viewModel.updateAccount(account, context);
                          }

                          // print(
                          //     "accountRegister.decentralizationId = ${accountRegister.decentralizationId}");
                          // print(
                          //     "accountRegister.statusId = ${accountRegister.statusId}");
                        },
                        child: const Text('Submit')),
                  ],
                ),
              ],
            ),
          ),
        ),
        'Sửa tài khoản id = ${account.id}',
        context);
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
