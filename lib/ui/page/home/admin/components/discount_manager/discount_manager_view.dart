// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../extendsion/extendsion.dart';
import '../../../../../component_common/my_dropdown_button2.dart';
import '../../../../../component_common/paginator_common.dart';
import '../../../../../component_common/textfield_common.dart';
import '../../../../../dialog/dialog_common.dart';
import '../statistical/statistical_view.dart';
import 'components/dialog_discount.dart';
import 'discount_manager_view_model.dart';

class DiscountManagerView extends StatefulWidget {
  const DiscountManagerView({super.key});

  @override
  State<DiscountManagerView> createState() => _DiscountManagerViewState();
}

class _DiscountManagerViewState extends State<DiscountManagerView> {
  final viewModel = Get.find<DiscountManagerViewModel>();

  final TextEditingController txtSearch = TextEditingController();

  final dialog = DialogDiscount();

  @override
  void initState() {
    super.initState();
    txtSearch.addListener(() {
      final text = txtSearch.text.trim();
      print('text:' + text);
      // viewModel.keyword.value = text;
      viewModel.getDiscountList();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    txtSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Text(
                    'Danh sách mã giảm giá:',
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: TextFieldCommon(
                      hintText: 'Tìm kiếm',
                      controller: txtSearch,
                      // onChanged: (value) {
                      //   viewModel.keyword.value = txtSearch.text.trim();
                      //   viewModel.getManufacturerList();
                      // },
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Obx(
                    () => IgnorePointer(
                      ignoring: viewModel.loading.value,
                      child: ElevatedButton(
                          onPressed: () {
                            dialog.showUpdateDialog(context);
                          },
                          child: const Text('Thêm mã giảm giá')),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  // Obx(
                  //   () => MyDropdownButton2StateFull(
                  //     hint: '',
                  //     value: viewModel.selectedItem.value,
                  //     itemHeight: 20,
                  //     dropdownItems: pageStep,
                  //     onChanged: (value) {
                  //       if (value != null) {
                  //         viewModel.onStepChange(value);
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Mã code',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Giá trị của mã giảm',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Thời gian hết hạn',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 121,
                    child: Text('Chức năng'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // padding: const EdgeInsets.all(16),
                color: Colors.white54,
                child: Obx(
                  () => viewModel.loading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount: viewModel.discountList.value.length,
                          itemBuilder: (context, index) => Container(
                            color: index % 2 == 0
                                ? Colors.white
                                : Colors.blue.shade100,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      '${viewModel.discountList.value[index].code}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      viewModel.discountList.value[index]
                                              .discount
                                              ?.toString() ??
                                          "",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      formatDateTime(
                                        viewModel.discountList.value[index]
                                                .expirationDate ??
                                            DateTime.now(),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            dialog.showUpdateDialog(context,
                                                itemUpdate: viewModel
                                                    .discountList.value[index]);
                                          },
                                          child: const Text('Sửa')),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            DialogCommon()
                                                .showDeleteConfirmation(
                                              context,
                                              text:
                                                  'mã giảm giá ${viewModel.discountList.value[index].code}',
                                              () => viewModel.deleteDiscount(
                                                  viewModel.discountList
                                                      .value[index]),
                                            );
                                          },
                                          child: const Text('Xóa')),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: !viewModel.loading.value,
                child: PaginatorCommon(
                  totalPage: viewModel.totalPage.value,
                  initPage: viewModel.currentPage.value - 1,
                  // onPageChangeCallBack: (index) =>
                  //     viewModel.onPageChange(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
