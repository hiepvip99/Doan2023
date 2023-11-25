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
  RxString validate = ''.obs;
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
              const Gap(4),
              Obx(
                () => Row(
                  children: [
                    Text(
                      validate.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(50),
              
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      validate.value = '';
                      final email = txtEmail.text.trim();
                      viewModel.email.value = email;
                      if (viewModel.email.value.trim().isEmpty) {
                        validate.value = "Email không được để trống";
                      } else if (!(viewModel.email.value.contains('@') &&
                          viewModel.email.value.contains('.'))) {
                        validate.value = "Email không đúng định dạng";
                      }
                      if (validate.value.trim().isEmail) {
                        viewModel.forgotPass();
                      }
                      
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
