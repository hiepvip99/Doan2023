// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../../extendsion/extendsion.dart';
import '../../../../../../../model/network/order_manager_model.dart';
import '../../../../../../component_common/textfield_common.dart';
import '../../../../../../dialog/dialog_common.dart';
import '../order_manager_view_model.dart';

class DialogOrder {
  final viewModel = Get.find<OrderManagerViewModel>();

  Future<void> showDetailDialog(BuildContext context, int index) async {
    // orderValue.value = order;
    DialogCommon().showDialogWithBody(
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
                Text(
                    'Phương thức thanh toán: ${viewModel.listOrder.value[index].paymentMethods ?? ''}'),
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
                  () => Text(
                      'Trạng thái đơn hàng: ${viewModel.listStatusOrder.firstWhereOrNull((element) => element.id == viewModel.listOrder.value[index].statusId)?.name ?? ''}'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: viewModel.listStatusOrder
                        .map((e) => ElevatedButton(
                              onPressed: (((e.id ?? 1) - 1) ==
                                              (viewModel.listOrder.value[index]
                                                      .statusId ??
                                                  1) &&
                                          e.name != 'Đã hủy' &&
                                          e.name != 'Trả hàng') ||
                                      ((viewModel.listOrder.value[index]
                                                      .statusId ??
                                                  1) <=
                                              3 &&
                                          e.name == 'Đã hủy') ||
                                      (viewModel.listOrder.value[index]
                                                  .statusId ==
                                              6 &&
                                          e.name == 'Trả hàng')
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
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      generatePdf(context, viewModel.listOrder.value[index]);
                      // Get.to(() => PdfGenerator(
                      //     order: viewModel.listOrder.value[index]));
                    },
                    child: const Text('Tạo pdf')),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> generatePdf(BuildContext context, Order order) async {
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/Roboto-Black.ttf");
    final ttf = pw.Font.ttf(font);
    // Add a page to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: buildContent(ttf, order),
        ),
      ),
    );

    // Save the PDF file
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/order_info.pdf");
    await file.writeAsBytes(await pdf.save());
    debugPrint('${output.path}/order_info.pdf');
    file.open();
    // final Uri url = Uri.parse(file.path);
    // launchUrl(url);
    // File('${output.path}/order_info.pdf').ope;

    // Open the PDF file
    // You can use any PDF viewer installed on the device
    // For example, you can use the open_file package
    OpenFile.open(file.path);
  }

  pw.Widget buildContent(pw.Font font, Order order, {double fontSize = 14}) {
    final styleFontPDF = pw.TextStyle(
      font: font,
      fontSize: fontSize,
    );
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Header(
          level: 0,
          child: pw.Text('Thông tin đơn hàng',
              style: styleFontPDF.copyWith(fontSize: 18)),
        ),
        pw.Text('Đơn hàng có id: ${order.id}', style: styleFontPDF),
        pw.Divider(),
        pw.Text('Thông tin khách hàng:', style: styleFontPDF),
        pw.Text('Họ và tên: ${order.customerInfo?.name}', style: styleFontPDF),
        pw.Text('Số điện thoại: ${order.customerInfo?.phoneNumber}',
            style: styleFontPDF),
        pw.Text('Thông tin đơn hàng:', style: styleFontPDF),
        pw.Text('Địa chỉ nhận hàng: ${order.deliveryAddress}',
            style: styleFontPDF),
        pw.Divider(),
        if (order.details?.length != 0)
          ...order.details!
              .map((e) => pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Tên sản phẩm: ${e.product?.name}',
                            style: styleFontPDF),
                        pw.Text('Số lượng: ${e.quantity}', style: styleFontPDF),
                      ]))
              .toList(),
        pw.Divider(),
        pw.Text('Thành tiền: ${formatMoney(order.totalPrice ?? 0)}',
            style: styleFontPDF),
        pw.Text('Tổng số lượng sản phẩm: ${order.totalQuantity} đôi',
            style: styleFontPDF),
        pw.Text('Phương thức thanh toán: ${order.paymentMethods}',
            style: styleFontPDF),
        // pw.Text('Mô tả đơn hà: ${order.paymentMethods}'),
      ],
    );
  }
}
