import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/home_user.dart';
import 'package:web_app/ui/page/home/user/my_order_manager/my_order_view.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  static String route = '/OrderSuccessScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt hàng thành công'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
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
            //     Get.toNamed(MyOrderView.route);
            //   },
            //   child: const Text('Xem lịch sử đơn hàng'),
            // ),
          ],
        ),
      ),
    );
  }
}
