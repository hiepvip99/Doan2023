import 'package:flutter/material.dart';

import '../../../../login/login_controller.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            LoginController().logoutApp();
          },
          child: const Text('Đăng xuất')),
    );
  }
}
