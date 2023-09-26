import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constant.dart';
import '../../../../../component_common/my_dropdown_button2.dart';
import '../../../../../component_common/paginator_common.dart';
import '../../../../../component_common/textfield_common.dart';
import 'customer_view_model.dart';

class CustomerView extends StatelessWidget {
  CustomerView({super.key});

  final viewModel = CustomerViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row(
            //   children: [],
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Text(
                    'Danh sách danh mục:',
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  // Expanded(
                  //   child: TextFieldCommon(
                  //     hintText: 'Tìm kiếm',
                  //     controller: txtSearch,
                  //     // onChanged: (value) {
                  //     //   viewModel.keyword.value = txtSearch.text.trim();
                  //     //   viewModel.getManufacturerList();
                  //     // },
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 50,
                  // ),
                  // Obx(
                  //   () => IgnorePointer(
                  //     ignoring: viewModel.loading.value,
                  //     child: ElevatedButton(
                  //         onPressed: () {
                  //           dialog.showAddDialog(context);
                  //         },
                  //         child: const Text('Thêm danh mục')),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 50,
                  // ),
                  Obx(
                    () => MyDropdownButton2StateFull(
                      hint: '',
                      value: viewModel.selectedItem.value,
                      itemHeight: 20,
                      dropdownItems: pageStep,
                      onChanged: (value) {
                        if (value != null) {
                          viewModel.onStepChange(value);
                        }
                      },
                    ),
                  ),
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
                    width: 80,
                    child: Text(
                      'ID',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Tên danh mục',
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
                          itemCount: viewModel.customerList.value.length,
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
                                    width: 80,
                                    child: Text(
                                      '${viewModel.customerList.value[index].id}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      viewModel
                                              .customerList.value[index].name ??
                                          "",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            // dialog.showUpdateDialog(
                                            //     context,
                                            //     viewModel
                                            //         .customerList.value[index]);
                                          },
                                          child: const Text('Sửa')),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            // Get.find<DialogCommon>()
                                            //     .showDeleteConfirmation(
                                            //   context,
                                            //   text:
                                            //       'danh mục ${viewModel.customerList.value[index].name} với id: ${viewModel.categoryList.value[index].id}',
                                            //   () => null,
                                            // );
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
                  onPageChangeCallBack: (index) =>
                      viewModel.onPageChange(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
