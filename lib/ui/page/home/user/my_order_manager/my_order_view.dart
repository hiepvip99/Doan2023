// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/extendsion/extendsion.dart';
import 'package:web_app/ui/page/home/admin/components/product_manager/product_manager_view.dart';

import '../../../../../constant.dart';
import '../../../../../model/network/order_manager_model.dart';
import '../../../../component_common/loading_widget.dart';
import 'my_order_view_model.dart';

class MyOrderView extends StatelessWidget {
  MyOrderView({super.key});

  static const route = '/OrderHistoryScreen';

  final viewModel = Get.find<MyOrderViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đặt hàng'),
      ),
      body: Obx(() => viewModel.loading.value
          ? const LoadingWidget()
          : DefaultTabController(
              length: viewModel.listStatusOrder.value.length,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                      tabAlignment: TabAlignment.start,
                      // padding: EdgeInsets.zero,
                      labelColor: Colors.black,
                      isScrollable: true,
                      tabs: viewModel.listStatusOrder.value
                          .map((e) => Tab(
                                text: e.name ?? '',
                              ))
                          .toList()),
                  Expanded(
                      child: TabBarView(
                          children: viewModel.listStatusOrder.value.map((e) {
                    List<Order> orderList = [];
                    for (var element in viewModel.listOrder.value) {
                      orderList.add(element);
                    }
                    orderList
                        .retainWhere((element) => e.id == element.statusId);
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...orderList.map((item) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Mã đơn hàng: ${item.id}'),
                                              OutlinedButton(
                                                  onPressed: () {
                                                    viewModel
                                                        .toDetailOrderScreen(
                                                            item);
                                                  },
                                                  child: const Text(
                                                      'Xem chi tiết')),
                                            ],
                                          ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          //  if(item.details!= null)
                                          const Divider(),
                                          ...item.details!.map(
                                            (itemDetail) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  leading: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: ImageComponent(
                                                        isShowBorder: false,
                                                        imageUrl: domain +
                                                            (itemDetail
                                                                        .color
                                                                        ?.images
                                                                        ?.length !=
                                                                    0
                                                                ? itemDetail
                                                                        .color
                                                                        ?.images
                                                                        ?.first
                                                                        .url ??
                                                                    ''
                                                                : '')),
                                                  ),
                                                  title: Text(
                                                    itemDetail.product?.name ??
                                                        '',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                              ],
                                            ),
                                          ),
                                          const Divider(),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  '${item.totalQuantity} sản phẩm'),
                                              Text(
                                                  'Tổng giá trị: ${formatMoney(item.totalPrice ?? 0)}'),
                                            ],
                                          ),
                                          // const Divider(),
                                          // Container(
                                          //   color: Colors.green,
                                          //   child: ListTile(
                                          //     contentPadding: EdgeInsets.zero,
                                          //     leading: SizedBox(
                                          //       width: 50,
                                          //       height: 50,
                                          //       child: ImageComponent(
                                          //           isShowBorder: false,
                                          //           imageUrl: domain +
                                          //               (item.details?.first.color?.images
                                          //                       ?.first.url ??
                                          //                   '')),
                                          //     ),
                                          //     title: Text(
                                          //       item.details?.first.product?.name ?? '',
                                          //       overflow: TextOverflow.ellipsis,
                                          //     ),
                                          //     subtitle: Text(
                                          //         'Số lượng: ${item.totalQuantity} || ${item.totalPrice} đ'),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    const Divider(thickness: 1),
                                  ],
                                )),

                            // ...orderList.map(
                            //   (item) => ListTile(
                            //     leading: SizedBox(
                            //       width: 50,
                            //       height: 50,
                            //       child: ImageComponent(
                            //           isShowBorder: false,
                            //           imageUrl: domain +
                            //               (item.details?.first.color?.images?.first
                            //                       .url ??
                            //                   '')),
                            //     ), // Hiển thị hình ảnh sản phẩm
                            //     title: Text(
                            //       item.details?.first.product?.name ?? '',
                            //       overflow: TextOverflow.ellipsis,
                            //     ), // Hiển thị tên sản phẩm
                            //     subtitle: Text((item.statusId ?? 0).toString(),
                            //         overflow: TextOverflow
                            //             .ellipsis), // Hiển thị trạng thái đơn hàng
                            //     trailing: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //
                            //       ],
                            //     ), // Hiển thị giá cả đơn hàng
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    );
                  }).toList()))
                ],
              ))),
      // body: ListView.builder(
      //   itemCount: 5,
      //   itemBuilder: (context, index) {
      //     return Card(
      //       child: ListTile(
      //         leading: Container(
      //           width: 60,
      //           height: 60,
      //           color: Colors.grey,
      //           child: Center(child: Text('Image')),
      //         ),
      //         title: Text('Order #${index + 1}'),
      //         subtitle: Text('Date: 2023-09-27'),
      //         trailing: Text('\$50'),
      //         onTap: () {
      //           // Xử lý khi người dùng nhấn vào một đơn hàng
      //         },
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
