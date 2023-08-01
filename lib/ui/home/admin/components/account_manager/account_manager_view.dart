import 'package:flutter/material.dart';

class AccountManager extends StatelessWidget {
  const AccountManager({super.key});

  static const router = '/AccountManager';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Text('Danh sách tài khoản:'),
              ElevatedButton(onPressed: () {}, child: Text('Thêm tài khoản'))
            ],
          )
        ],
      ),
    );
  }
}
