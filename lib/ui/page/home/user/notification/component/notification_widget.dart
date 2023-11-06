import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../my_order_manager/my_order_view.dart';

class NotificationWidget extends StatelessWidget {
  final String title;
  final String message;

  const NotificationWidget({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(MyOrderView.route),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.edit_document,
                  size: 32,
                  color: Colors.blue,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey[400],
            )
          ],
        ),
      ),
    );
  }
}
