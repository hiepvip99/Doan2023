// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../component_common/paginator_common.dart';
import '../../../../../component_common/textfield_common.dart';
import 'order_manager_view_model.dart';

class OrderManagerView extends StatelessWidget {
  OrderManagerView({super.key});

  final OrderManagerViewModel controller = Get.find<OrderManagerViewModel>();

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
                        label: 'Tìm kiếm', controller: TextEditingController()),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // DialogAccount().showDialogAdd();
                      },
                      child: const Text('Thêm đơn hàng')),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'ID',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Họ và tên(id tài khoản to get name)',
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
                    width: 207,
                    child: Text('Chức năng'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // padding: const EdgeInsets.all(16),
                color: Colors.white54,
                child: ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  itemCount: controller.listOrder.value.length,
                  itemBuilder: (context, index) => Container(
                    color: index % 2 == 0 ? Colors.white : Colors.blue.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${controller.listOrder.value[index].id}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${controller.listOrder.value[index].accountId ?? 0}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              controller.listOrder.value[index].date ?? '',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${controller.listOrder.value[index].totalPrice ?? 0}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${controller.listOrder.value[index].status ?? 0}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                  onPressed: () {}, child: const Text('Sửa')),
                              const SizedBox(
                                width: 8,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Chi tiết')),
                              const SizedBox(
                                width: 8,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: () {
                                    // DialogAccount()
                                    //     .showDeleteConfirmation(context);
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
            Obx(
              () => PaginatorCommon(
                totalPage: controller.totalPage.value,
                initPage: controller.currentPage.value - 1,
                onPageChangeCallBack: (index) => controller.onPageChange(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
