// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:web_app/model/network/order_manager_model.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';

import '../../../../../../constant.dart';
import '../../../../../../extendsion/extendsion.dart';
import '../../../../../component_common/loading_widget.dart';
import '../../../admin/components/product_manager/product_manager_view.dart';
import '../../review/product_review.dart';
import 'order_detail_view_model.dart';

class OrderDetailView extends StatelessWidget {
  OrderDetailView({super.key});

  static const route = '/OrderDetailView';

  final viewModel = Get.find<OrderDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trạng thái đơn hàng:',
                  ),
                  Obx(
                    () => Text(
                      viewModel.statusName.value,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.location_on,
                      ),
                    ),
                    Expanded(
                        child: Text(
                            'Địa chỉ nhận hàng: ${viewModel.order.value.deliveryAddress}')),
                    // Text
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 8.0),
                    //   child: Icon(
                    //     Icons.location_on,
                    //   ),
                    // ),
                    Text(
                        'Người nhận: ${viewModel.order.value.customerInfo?.name}'),
                    const SizedBox(
                      height: 8,
                    ),
                    // const Divider(),
                    Text(
                        'Số điện thoại: ${viewModel.order.value.customerInfo?.phoneNumber}'),
                    const Divider(),
                    Text('Mã đơn hàng: ${viewModel.order.value.id}'),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Thời gian đặt hàng:'),
                        Text(formatDateTime(
                            viewModel.order.value.orderDate ?? DateTime(1990))),
                      ],
                    ),
                    Obx(
                      () => Column(
                        children: [
                          ...viewModel.listTime.value
                              .map(
                                (e) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${viewModel.listStatusOrder.value.firstWhereOrNull((element) => element.id == e.statusId)?.name}:'),
                                    Text(formatDateTime7(DateTime.tryParse(
                                            e.changedTime ?? '') ??
                                        DateTime.now())),
                                  ],
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),
                    const Divider(),
                    // Text
                  ],
                ),
              ),
              Container(
                color: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    if (viewModel.order.value.details?.length != 0)
                      ...viewModel.order.value.details!.map(
                        (itemDetail) => Container(
                          // color: Colors.blue,
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                leading: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: ImageComponent(
                                      isShowBorder: false,
                                      imageUrl: domain +
                                          (itemDetail.color?.images?.length != 0
                                              ? itemDetail.color?.images?.first
                                                      .url ??
                                                  ''
                                              : '')),
                                ),
                                title: Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        itemDetail.product?.name ?? '',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Spacer(),
                                    RatingInOrder(
                                        viewModel: viewModel,
                                        itemDetail: itemDetail),
                                  ],
                                ),
                                subtitle: Text(
                                    'Số lượng: ${itemDetail.quantity ?? 0} || ${formatMoney(itemDetail.color?.price ?? 0)}'),
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 65,
                                  ),
                                  Obx(
                                    () => Text(
                                        'Phân loại: ${viewModel.getColorName(itemDetail.color?.colorId)} || ${viewModel.getSizeName(itemDetail.sizeId)}'),
                                  )
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${viewModel.order.value.totalQuantity} sản phẩm'),
                          Text(
                              'Tổng giá trị: ${formatMoney(viewModel.order.value.totalPrice ?? 0)}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              const Text('Phương thức thanh toán'),
              const SizedBox(
                height: 8,
              ),
              Text('${viewModel.order.value.paymentMethods}'),
              const Divider(),
              Obx(
                () => viewModel.loading.value &&
                        (viewModel.order.value.paymentMethods ==
                            'Thanh toán qua Qr')
                    ? const Column(
                        children: [
                          Text('Đang tải qr'),
                          LoadingWidget(),
                        ],
                      )
                    : Visibility(
                        visible: viewModel.order.value.paymentMethods ==
                                'Thanh toán qua Qr' &&
                            viewModel.base64Image.value.trim().isNotEmpty,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Image.memory(
                                  base64Decode(viewModel.base64Image.value
                                      .split('data:image/png;base64,')
                                      .last),
                                ),
                                const Gap(16),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                          'Sau khi thanh toán qua qr bạn hãy gửi ảnh vào zalo của shop nhé zalo là : 098.122.2070'),
                                    ),
                                    const Gap(16),
                                    ElevatedButton(
                                        onPressed: () {
                                          Clipboard.setData(const ClipboardData(
                                              text: '0981222070'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('Đã sao chép zalo'),
                                            ),
                                          );
                                        },
                                        child: const Text('Sao chép zalo:'))
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        // height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Visibility(
                    visible: viewModel.order.value.statusId == 1,
                    child: Expanded(
                        child: TextButton(
                            onPressed: viewModel.order.value.statusId == 1
                                ? () {
                                    DialogCommon().showConfirmDialog(
                                        Get.context!, 'Huỷ đơn hàng',
                                        text: 'Đơn hàng của bạn sẽ được huỷ',
                                        () {
                                      viewModel.changeStatus(5, 'Đã huỷ');
                                    });
                                  }
                                : null,
                            child: const Text('Huỷ đơn hàng')))),
              ),
              // ElevatedButton(onPressed: () {}, child: Text('Huỷ đơn hàng')),
              Obx(
                () => SizedBox(
                  width: viewModel.order.value.statusId == 1 ? 8 : 0,
                ),
              ),
              Expanded(
                  child: ElevatedButton(
                      onPressed: viewModel.order.value.statusId == 4
                          ? () {
                              DialogCommon().showConfirmDialog(
                                  text:
                                      'Đơn hàng của bạn sẽ được trả lại cho nguời bán và hoàn tiền sau khi xác nhận',
                                  Get.context!,
                                  'Trả hàng', () {
                                viewModel.changeStatus(6, 'Trả hàng');
                              });
                            }
                          : null,
                      child: const Text('Trả hàng'))),
              Visibility(
                  visible: viewModel.order.value.statusId == 5,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: viewModel.order.value.statusId == 5
                              ? () {
                                  DialogCommon().showConfirmDialog(
                                      text:
                                          'Đơn hàng của bạn sẽ được hoàn tiền sau khi xác nhận',
                                      Get.context!,
                                      'Yêu cầu hoàn tiền', () {
                                    viewModel.changeStatus(
                                        7, 'Yêu cầu hoàn tiền');
                                  });
                                }
                              : null,
                          child: const Text('Yêu cầu hoàn tiền')),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class RatingInOrder extends StatefulWidget {
  const RatingInOrder({
    super.key,
    required this.viewModel,
    this.itemDetail,
  });

  final OrderDetailViewModel viewModel;
  final Details? itemDetail;

  @override
  State<RatingInOrder> createState() => _RatingInOrderState();
}

class _RatingInOrderState extends State<RatingInOrder> {
  @override
  void initState() {
    super.initState();
    widget.viewModel
        .checkRating(widget.itemDetail?.id, widget.itemDetail?.product?.id);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: widget.viewModel.order.value.statusId == 4 &&
            widget.viewModel.hasRating.value,
        child: OutlinedButton(
            onPressed: () {
              // showModalBottomSheet(
              //   context: context,
              //   builder: (context) =>
              //       const ProductReviewPage(),
              // );
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useRootNavigator: true,
                builder: (context) =>
                    ProductReviewPage(itemDetail: widget.itemDetail),
              ).then((value) {
                widget.viewModel.checkRating(
                    widget.itemDetail?.id, widget.itemDetail?.product?.id);
              });
              // Get.toNamed(ProductReviewPage.route);
            },
            child: const Text('Đánh giá')),
      ),
    );
  }
}
