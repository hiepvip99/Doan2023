import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../component_common/loading_widget.dart';
import '../order_view_model.dart';

class PayQr extends StatelessWidget {
  PayQr({super.key});

  final viewModel = Get.find<OrderViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thanh toán qr'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            Obx(
              () => viewModel.loading.value
                  ? const Column(
                      children: [
                        Text('Đang tải qr thanh toán cho bạn'),
                        Gap(16),
                        LoadingWidget(),
                      ],
                    )
                  : Visibility(
                      visible: viewModel.radioselectedPaymentMethod.value ==
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
        ));
  }
}
