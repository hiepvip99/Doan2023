import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/input_text_with_title.dart';

import '../../../../../../../model/network/manufacturer_model.dart';
import '../../../../../../dialog/dialog_common.dart';

class DialogManufacturer {
  // Future<void> showDialog(BuildContext context) async {
  //   Get.find<DialogCommon>().showDialogWithBody(
  //     context,
  //     title: "Thêm tài khoản" /*  'Thêm tài khoản' */,
  //     bodyDialog: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         const SizedBox(
  //           height: 16,
  //         ),
  //         body,
  //       ],
  //     ),
  //   );
  // }

  // Future<void> showDialog(BuildContext context, Manufacturer itemUpdate) async {
  //   Manufacturer manufacturer = itemUpdate;
  //   TextEditingController txtName =
  //       TextEditingController(text: manufacturer.name);
  //   Get.find<DialogCommon>().showDialogWithBody(
  //     context,
  //     title: 'Sửa nhà sản xuất có id: ${itemUpdate.id}' /*  'Thêm tài khoản' */,
  //     bodyDialog: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         const SizedBox(
  //           height: 16,
  //         ),
  //         InputTextWithTitle(
  //             textEditingController: txtName, title: 'Tên nhà sản xuất'),
  //       ],
  //     ),
  //   );
  // }
}
