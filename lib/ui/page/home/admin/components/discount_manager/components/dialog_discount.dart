import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:web_app/extendsion/extendsion.dart';

import '../../../../../../../model/network/discount_model.dart';
import '../../../../../../component_common/textfield_common.dart';
import '../../../../../../dialog/dialog_common.dart';
import '../../statistical/statistical_view.dart';
import '../discount_manager_view_model.dart';
// import '../discounts_manager_view_model.dart';

class DialogDiscount {
  final viewModel = Get.find<DiscountManagerViewModel>();

  String? validateName(String value) {
    if (value.trim().isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }

  Future<void> showUpdateDialog(BuildContext context,
      {Discount? itemUpdate}) async {
    Discount discount = itemUpdate ?? Discount();
    TextEditingController txtCode = TextEditingController(text: discount.code);
    TextEditingController txtGiatri =
        TextEditingController(text: discount.discount?.toString() ?? '');
    Rx<DateTime> chooseDate = Rx(discount.expirationDate ?? DateTime.now());
    // final _formKey = GlobalKey<FormState>();
    DialogCommon().showDialogWithBody(
      height: 350,
      context,
      title: itemUpdate != null
          ? ' Sửa mã giảm giá có code: ${discount.code ?? ''}'
          : 'Thêm mã giảm giá' /*  'Thêm tài khoản' */,
      bodyDialog: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text('Mã code ${itemUpdate == null ? '' : itemUpdate.code}'),
          Visibility(
            visible: itemUpdate == null,
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                TextFieldCommon(
                  controller: txtCode,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text('Giá trị mã giảm'),
          const SizedBox(
            height: 8,
          ),
          TextFieldCommon(
            controller: txtGiatri,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Text('Thời gian hết hạn'),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Obx(() => Text('Thời gian ${formatDateTime(chooseDate.value)}')),
              IconButton(
                  onPressed: () async {
                    showDatePicker(context, (value) {
                      chooseDate.value = value;
                    },
                        discount.expirationDate != null
                            ? discount.expirationDate!
                            : DateTime.now());
                  },
                  icon: const Icon(Icons.date_range)),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    discount.code = txtCode.text.trim();
                    discount.discount = int.parse(txtGiatri.text.trim());
                    discount.expirationDate = chooseDate.value;
                    Get.back();
                    if (itemUpdate != null) {
                      viewModel.updateDiscount(discount);
                    } else {
                      viewModel.addDiscount(discount);
                    }
                    // }
                  },
                  child: const Text('Xác nhận')),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> showDatePicker(BuildContext context,
      Function(DateTime value) onChangeDate, DateTime initDate) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 220,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                use24hFormat: true,
                onDateTimeChanged: (value) => onChangeDate(value),
                initialDateTime: initDate,
                minimumDate: DateTime(2010),
                maximumDate: DateTime(2050)),
          ),
        ),
      ),
    );
  }
}
