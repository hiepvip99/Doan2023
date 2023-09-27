import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  static const route = '/OrderHistoryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                color: Colors.grey,
                child: Center(child: Text('Image')),
              ),
              title: Text('Order #${index + 1}'),
              subtitle: Text('Date: 2023-09-27'),
              trailing: Text('\$50'),
              onTap: () {
                // Xử lý khi người dùng nhấn vào một đơn hàng
              },
            ),
          );
        },
      ),
    );
  }
}
