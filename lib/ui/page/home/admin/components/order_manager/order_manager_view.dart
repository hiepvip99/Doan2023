// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_app/ui/page/home/admin/components/order_manager/components/dialog_order.dart';

import '../../../../../../constant.dart';
import '../../../../../component_common/my_dropdown_button2.dart';
import '../../../../../component_common/paginator_common.dart';
import '../../../../../component_common/textfield_common.dart';
import 'order_manager_view_model.dart';

class OrderManagerView extends StatefulWidget {
  const OrderManagerView({super.key});

  @override
  State<OrderManagerView> createState() => _OrderManagerViewState();
}

class _OrderManagerViewState extends State<OrderManagerView> {
  final OrderManagerViewModel viewModel = Get.find<OrderManagerViewModel>();

  // @override
  // void initState() {
  //   super.initState();
  //   viewModel.getOrderList();
  // }

  final TextEditingController txtSearch = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtSearch.addListener(() {
      final text = txtSearch.text.trim();
      print('text:' + text);
      viewModel.keyword.value = text;
      viewModel.currentPage.value = 1;
      viewModel.getOrderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Text(
                    'Danh sách đơn hàng:',
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    flex: 7,
                    // child: TextField(
                    //   decoration: InputDecoration(
                    //       label: Text('Tìm kiếm'),
                    //       border: OutlineInputBorder(),
                    //       contentPadding: EdgeInsets.all(8),
                    //       isDense: true),
                    // ),
                    child: TextFieldCommon(
                        label: 'Tìm kiếm', controller: txtSearch),
                  ),
                  // const SizedBox(
                  //   width: 50,
                  // ),
                  // Obx(
                  //   () => IgnorePointer(
                  //     ignoring: viewModel.loading.value,
                  //     child: ElevatedButton(
                  //         onPressed: () {
                  //           // DialogAccount().showDialogAdd();
                  //         },
                  //         child: const Text('Thêm đơn hàng')),
                  //   ),
                  // ),
                  const SizedBox(
                    width: 16,
                  ),
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
                    width: 50,
                    child: Text(
                      'ID',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Người đặt',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Ngày đặt',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Tổng giá trị',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Trạng thái',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 86,
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
                          itemCount: viewModel.listOrder.value.length,
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
                                    width: 50,
                                    child: Text(
                                      '${viewModel.listOrder.value[index].id}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      viewModel.listOrder.value[index]
                                              .customerInfo?.name ??
                                          '',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      viewModel.listOrder.value[index]
                                                  .orderDate !=
                                              null
                                          ? DateFormat('yyyy-MM-dd – HH:mm')
                                              .format(viewModel.listOrder
                                                      .value[index].orderDate ??
                                                  DateTime(9999))
                                          : '',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${viewModel.listOrder.value[index].totalPrice ?? 0}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${viewModel.listStatusOrder.firstWhereOrNull((element) => viewModel.listOrder.value[index].statusId == element.id)?.name ?? 0}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // ElevatedButton(
                                      //     onPressed: () {},
                                      //     child: const Text('Sửa')),
                                      // const SizedBox(
                                      //   width: 8,
                                      // ),
                                      ElevatedButton(
                                          onPressed: () {
                                            DialogOrder().showDetailDialog(
                                                context, index);
                                          },
                                          child: const Text('Chi tiết')),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      // ElevatedButton(
                                      //     style: ElevatedButton.styleFrom(
                                      //         backgroundColor: Colors.red),
                                      //     onPressed: () {
                                      //       // DialogAccount()
                                      //       //     .showDeleteConfirmation(context);
                                      //     },
                                      //     child: const Text('Xóa')),
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
