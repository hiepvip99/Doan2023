import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/textfield_beautiful.dart';

import 'forgot_pass_view_model.dart';

class ForgotPassView extends StatelessWidget {
  ForgotPassView({super.key});

  static const route = '/ForgotPassView';

  final TextEditingController txtEmail = TextEditingController();
  final viewModel = Get.find<ForgotPassViewModel>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quên mật khẩu'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                  'Bạn vui lòng nhập email đăng ký tài khoản của mình để nhận mã xác nhận'),
              const Gap(16),
              TextFieldBeautiful(
                  title: 'Nhập email đăng ký', controller: txtEmail),
              const Gap(50),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      final email = txtEmail.text.trim();
                      viewModel.email = email;
                      viewModel.forgotPass();
                    },
                    child: const Text('Gửi mã xác nhận')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
