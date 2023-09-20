// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../../model/network/order_manager_model.dart';
import '../../../../../../component_common/textfield_common.dart';
import '../../../../../../dialog/dialog_common.dart';
import '../order_manager_view_model.dart';

class DialogOrder {
  final viewModel = Get.find<OrderManagerViewModel>();

  Future<void> showDetailDialog(BuildContext context, int index) async {
    // orderValue.value = order;
    Get.find<DialogCommon>().showDialogWithBody(
      height: 500,
      context,
      title:
          "Đơn hàng có id: ${viewModel.listOrder.value[index].id}" /*  'Thêm tài khoản' */,
      bodyDialog: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin khách hàng:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'Họ và tên: ${viewModel.listOrder.value[index].customerInfo?.name ?? ''}'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'Số điện thoại: ${viewModel.listOrder.value[index].customerInfo?.phoneNumber ?? ''}'),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey.shade400,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Thông tin đơn hàng:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'Địa chỉ nhận hàng: ${viewModel.listOrder.value[index].deliveryAddress ?? ''}'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10)),
                  child: viewModel.listOrder.value[index].details != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: viewModel.listOrder.value[index].details!
                              .map((e) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Tên sản phẩm: ${e.product?.name ?? ''} đôi'),
                                      Text('Số lượng : ${e.quantity} đôi')
                                    ],
                                  ))
                              .toList(),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'Thành tiền: ${viewModel.listOrder.value[index].totalPrice} đ'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'Tổng số lượng sản phẩm: ${viewModel.listOrder.value[index].totalQuantity} đôi'),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: viewModel.listStatusOrder
                        .map((e) => ElevatedButton(
                              onPressed: ((e.id ?? 0) >
                                              (viewModel.listOrder.value[index]
                                                      .statusId ??
                                                  0) &&
                                          e.name != 'Đã hủy') ||
                                      ((viewModel.listOrder.value[index]
                                                      .statusId ??
                                                  0) <=
                                              3 &&
                                          e.name == 'Đã hủy')
                                  ? () {
                                      // Order item = order;

                                      viewModel.listOrder.value[index]
                                          .statusId = e.id;
                                      viewModel.listOrder.refresh();
                                      viewModel.changeStatus(
                                          viewModel.listOrder.value[index]);
                                    }
                                  : null,
                              child: Text('${e.name}'),
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
