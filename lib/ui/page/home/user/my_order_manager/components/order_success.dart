import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:web_app/service/network/order_service.dart';
import 'package:web_app/ui/page/home/user/home_user.dart';
import 'package:web_app/ui/page/home/user/my_order_manager/my_order_view.dart';

import '../../../../../../model/network/order_manager_model.dart';
import '../order_detail/order_detail_view.dart';
import '../order_detail/order_detail_view_model.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen(
      {super.key, required this.isQrCode, required this.order});

  final bool isQrCode;
  final Order order;

  static String route = '/OrderSuccessScreen';

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  void initState() {
    super.initState();

    genarateQr();
  }

  RxBool loading = true.obs;
  RxString base64Image = ''.obs;
  Future<void> genarateQr() async {
    loading.value = true;
    int? maxId;
    await OrderService().getMaxId().then((value) {
      if (value?.maxId != null) {
        maxId = value?.maxId;
      }
    });
    // base64Image.
    await OrderService()
        .genarateQr(GetQrGenarate(
            accountNo: '4520561495',
            accountName: 'LE CHI HIEP',
            acqId: 970418,
            amount: widget.order.totalPrice,
            addInfo: 'Pay to order id: ${(maxId ?? 0) + 1}',
            format: 'text',
            template: '96KCB5S'))
        .then((value) {
      if (value?.data?.qrDataURL != null) {
        base64Image.value = value?.data?.qrDataURL ?? '';
      }
    });

    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isQrCode
            ? 'Chưa hoàn thành đặt hàng'
            : 'Đặt hàng thành công'),
        centerTitle: true,
      ),
      body: Center(
        child: widget.isQrCode ? buildSuccessWithQr(context) : buildNoQr(),
      ),
    );
  }

  Widget buildSuccessWithQr(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const Icon(
        //   Icons.warning,
        //   size: 80,
        //   color: Colors.orange,
        // ),
        const SizedBox(height: 20),
        const Text(
          'Bạn cần thanh toán để hoàn thành đặt hàng qua Qr',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        Obx(
          () => Column(
            children: [
              Column(
                children: [
                  loading.value
                      ? const CircularProgressIndicator()
                      : Image.memory(
                          base64Decode(base64Image.value
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
                            Clipboard.setData(
                                const ClipboardData(text: '0981222070'));
                            ScaffoldMessenger.of(context).showSnackBar(
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
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Get.offAllNamed(HomeUser.route);
          },
          child: const Text('Mua sắm tiếp'),
        ),
      ],
    );
  }

  Column buildNoQr() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle,
          size: 80,
          color: Colors.green,
        ),
        const SizedBox(height: 16),
        const Text(
          'Bạn đã đặt hàng thành công',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Cảm ơn bạn!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Get.offAllNamed(HomeUser.route);
          },
          child: const Text('Mua sắm tiếp'),
        ),
        // const SizedBox(height: 16),
        // ElevatedButton(
        //   onPressed: () {
        //     Get.toNamed(HomeUser.route, arguments: 3);
        //   },
        //   child: const Text('Xem lịch sử đơn hàng'),
        // ),
      ],
    );
  }
}
