import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../../model/network/manufacturer_model.dart';
import '../../../../../../component_common/textfield_common.dart';
import '../../../../../../dialog/dialog_common.dart';
import '../manufacturers_manager_view_model.dart';

class DialogManufacturer {
  final viewModel = Get.find<ManufacturersViewModel>();

  String? validateName(String value) {
    if (value.trim().isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }

  Future<void> showAddDialog(BuildContext context) async {
    Manufacturer data = Manufacturer();
    TextEditingController txtName = TextEditingController();

    final formKey = GlobalKey<FormState>();

    DialogCommon().showDialogWithBody(
      height: 200,
      context,
      title: "Thêm nhà sản xuất" /*  'Thêm tài khoản' */,
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
              //   FilteringTextInputFormatter.allow(RegExp(r'^\s+|\s+$'))
              // ],
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
                        viewModel.addManufacturer(data);
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
      BuildContext context, Manufacturer itemUpdate) async {
    Manufacturer manufacturer = itemUpdate;
    TextEditingController txtName =
        TextEditingController(text: manufacturer.name);
    final _formKey = GlobalKey<FormState>();
    DialogCommon().showDialogWithBody(
      context,
      title: 'Sửa nhà sản xuất có id: ${itemUpdate.id}' /*  'Thêm tài khoản' */,
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
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(RegExp(r'^\s+|\s+$'))
              // ],
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
                        manufacturer.name = txtName.text.trim();
                        Get.back();
                        viewModel.updateManufacturer(manufacturer);
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
