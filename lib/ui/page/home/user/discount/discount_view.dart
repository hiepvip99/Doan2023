// ignore_for_file: invalid_use_of_protected_member

import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/loading_widget.dart';

import 'discount_view_model.dart';

class DiscountCodeView extends StatefulWidget {
  static const route = '/DiscountCodeView';

  // final List<String> viewModel.discountList.value = [
  //   'CODE123',
  //   'DISCOUNT50',
  //   'SALE25',
  //   'SAVE10',
  // ];

  const DiscountCodeView({super.key});

  @override
  State<DiscountCodeView> createState() => _DiscountCodeViewState();
}

class _DiscountCodeViewState extends State<DiscountCodeView> {
  final viewModel = Get.find<DiscountViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mã giảm giá'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () => viewModel.loading.value
              ? const LoadingWidget()
              : ListView.builder(
                  itemCount: viewModel.discountList.value.length,
                  itemBuilder: (context, index) {
                    final discountCode = viewModel.discountList.value[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: discountCode.code ?? ''));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Đã sao chép mã giảm giá : ${discountCode.code}'),
                            ),
                          );
                        },
                        child: CouponCard(
                            height: 100,
                            curveAxis: Axis.vertical,
                            firstChild: Container(
                              color: Colors.blue,
                              child: Center(
                                  child: Text(
                                      'Mã giảm giá: ${discountCode.code}')),
                            ),
                            secondChild: Container(
                              color: Colors.lightBlueAccent,
                              child: Center(
                                  child: Text(
                                      'Mã giảm giá này giảm ${discountCode.discount ?? 0}đ cho mỗi đơn hàng')),
                            )),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
