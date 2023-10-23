import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../../model/network/category_model.dart';
import '../../../../../../component_common/textfield_common.dart';
import '../../../../../../dialog/dialog_common.dart';
import '../category_view_model.dart';

class DialogCategory {
  final viewModel = Get.find<CategoryViewModel>();

  String? validateName(String value) {
    if (value.trim().isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }

  Future<void> showAddDialog(BuildContext context) async {
    Category data = Category();
    TextEditingController txtName = TextEditingController();

    final formKey = GlobalKey<FormState>();

    DialogCommon().showDialogWithBody(
      height: 200,
      context,
      title: "Thêm danh mục" /*  'Thêm tài khoản' */,
      bodyDialog: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            TextFieldCommon(
              controller: txtName,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\s+|\s+$'))
              ],
              validator: (value) {
                return validateName(value ?? '');
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        data.name = txtName.text.trim();
                        Get.back();
                        viewModel.addCategory(data);
                      }
                    },
                    child: const Text('Xác nhận')),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Future<void> showUpdateDialog(
      BuildContext context, Category itemUpdate) async {
    Category category = itemUpdate;
    TextEditingController txtName = TextEditingController(text: category.name);
    final formKey = GlobalKey<FormState>();
    DialogCommon().showDialogWithBody(
      context,
      title: 'Sửa danh mục có id: ${itemUpdate.id}' /*  'Thêm tài khoản' */,
      bodyDialog: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            TextFieldCommon(
              controller: txtName,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\s+|\s+$'))
              ],
              validator: (value) {
                return validateName(value ?? '');
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        category.name = txtName.text.trim();
                        Get.back();
                        viewModel.updateCategory(category);
                      }
                    },
                    child: const Text('Xác nhận')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
