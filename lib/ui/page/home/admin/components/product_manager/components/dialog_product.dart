// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:web_app/ui/component_common/textfield_common.dart';

import '../../../../../../../model/network/product_manager_model.dart';
import '../../../../../../component_common/close_button.dart';
import '../../../../../../component_common/delete_body_dialog_common.dart';
import '../../../../../../component_common/dropdown_button_common.dart';
import '../../../../../../dialog/dialog_common.dart';
import '../product_manager_view_model.dart';

class DialogProduct {
  final ProductManagerViewModel viewModel;
  DialogProduct({
    required this.viewModel,
  });

  void addProductDialog(BuildContext context, Rx<Product> itemAdd) {
    Get.find<DialogCommon>().showDialogWithBody(
      context,
      height: 450,
      width: 650,
      bodyDialog: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ảnh:'),
                SizedBox(
                  width: 100,
                  height: 100,
                )
                // Image.memory(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // Image.memory(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nhà sản xuất:'),
                DropdownButtonCommon(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tên sản phẩm:'),
                SizedBox(
                    width: 300,
                    child: TextFieldCommon(controller: TextEditingController()))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Màu sắc:'),
                DropDownMutltiSelection(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Số lượng:'),
                SizedBox(
                    width: 300,
                    child: TextFieldCommon(controller: TextEditingController()))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Giá:'),
                SizedBox(
                    width: 300,
                    child: TextFieldCommon(controller: TextEditingController()))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Giới tính:'),
                DropdownButtonCommon(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
