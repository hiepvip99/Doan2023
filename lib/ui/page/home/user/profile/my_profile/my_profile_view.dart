import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/edit_image.dart';
import 'package:web_app/ui/component_common/textfield_common.dart';

import '../../../../../component_common/button_beautiful.dart';
import '../../../../../component_common/textfield_beautiful.dart';
import 'my_profile_view_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const route = '/EditProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final viewModel = Get.find<EditProfileViewModel>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chỉnh sửa thông tin'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const EditAvatarScreen(),
              const SizedBox(
                height: 16,
              ),
              TextFieldBeautiful(
                  title: 'Họ và tên', controller: _nameController),
              const SizedBox(
                height: 16,
              ),
              TextFieldBeautiful(
                title: 'Số điện thoại',
                controller: _phoneController,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFieldBeautiful(
                title: 'Ngày sinh',
                controller: _dobController,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFieldBeautiful(
                title: 'Email',
                controller: _emailController,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFieldBeautiful(
                title: 'Địa chỉ',
                controller: _addressController,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                      child: ButtonBeautiful(
                    onTap: () {
                      // Xử lý khi nhấn nút Lưu
                      // Lấy giá trị từ các trường thông tin
                      String name = _nameController.text;
                      String phone = _phoneController.text;
                      String dob = _dobController.text;
                      String email = _emailController.text;
                      String address = _addressController.text;

                      // Thực hiện lưu thông tin người dùng
                      // ...

                      // Đưa người dùng trở lại màn hình trước đó
                      Navigator.pop(context);
                    },
                    title: 'Lưu thông tin',
                  )),
                ],
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
