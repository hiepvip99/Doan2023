import 'package:flutter/material.dart' hide Size;
import 'package:flutter/services.dart' hide Size;
import 'package:get/get.dart';

import '../../../../../../../model/network/color_model.dart';
import '../../../../../../../model/network/size_model.dart';
import '../../../../../../component_common/textfield_common.dart';
import '../../../../../../dialog/dialog_common.dart';
import '../size_manager_view_model.dart';

class DialogSize {
  final viewModel = Get.find<SizeViewModel>();

  String? validateName(String value) {
    if (value.trim().isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }

  Future<void> showAddDialog(BuildContext context) async {
    Size data = Size();
    TextEditingController txtName = TextEditingController();

    final formKey = GlobalKey<FormState>();

    DialogCommon().showDialogWithBody(
      height: 180,
      context,
      title: "Thêm size" /*  'Thêm tài khoản' */,
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
              // inputFormatters: [
              //   // FilteringTextInputFormatter.allow(RegExp(r'^\s+|\s+$'))
              // ],
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                        viewModel.addSize(data);
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

  Future<void> showUpdateDialog(BuildContext context, Size itemUpdate) async {
    Size color = itemUpdate;
    TextEditingController txtName = TextEditingController(text: color.name);
    final _formKey = GlobalKey<FormState>();
    DialogCommon().showDialogWithBody(
      context,
      height: 180,
      title: 'Sửa size có id: ${itemUpdate.id}' /*  'Thêm tài khoản' */,
      bodyDialog: Form(
        key: _formKey,
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
                      if (_formKey.currentState!.validate()) {
                        color.name = txtName.text.trim();
                        Get.back();
                        viewModel.updateSize(color);
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
