import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:web_app/ui/component_common/textfield_beautiful.dart';

class UpdatePass extends StatefulWidget {
  const UpdatePass({super.key});

  @override
  State<UpdatePass> createState() => _UpdatePassState();
}

class _UpdatePassState extends State<UpdatePass> {
  final TextEditingController txtPass = TextEditingController();

  final TextEditingController txtConfirmPass = TextEditingController();

  final FocusNode _focusNodePassword = FocusNode();

  final FocusNode _focusNodeConfirm = FocusNode();

  bool _obscurePassword = true;
  bool showValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật mật khẩu mới',
            overflow: TextOverflow.ellipsis),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Row(
            children: [
              Text(
                'Nhập mật khẩu mới',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: txtPass,
            focusNode: _focusNodePassword,
            obscureText: _obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.lightBlueAccent),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                // borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onEditingComplete: () => _focusNodeConfirm.requestFocus(),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Vui lòng nhập mật khẩu mới";
              }
              if (value.length < 8) {
                return "Mật khẩu mới phải từ 8 kí tự";
              }

              return null;
            },
          ),
          const Row(
            children: [
              Text(
                'Nhập lại mật khẩu',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: txtPass,
            focusNode: _focusNodeConfirm,
            obscureText: _obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.lightBlueAccent),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                // borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              setState(() {
                showValidate = false;
              });
            },
            onEditingComplete: () => _focusNodeConfirm.requestFocus(),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Vui lòng nhập";
              }
              if (value.length < 8) {
                return "Mật khẩu phải từ 8 kí tự";
              }
              if (showValidate && value.isNotEmpty) {
                return 'Mật khẩu không khớp';
              }

              return null;
            },
          ),
          const Gap(16),
          Center(
            child: ElevatedButton(
                onPressed: () {}, child: const Text('Cập nhật mật khẩu')),
          )
          // TextFieldBeautiful(title: 'Nhập mật khẩu mới', controller: controller)
          // TextFieldBeautiful(title: 'Nhập lại mật khẩu', controller: controller)
        ],
      ),
    );
  }
}
