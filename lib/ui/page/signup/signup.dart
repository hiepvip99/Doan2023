import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../model/network/login_model.dart';
import '../login/login_controller.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  // final Box _boxAccounts = Hive.box("accounts");
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar:
            AppBar(title: const Text('Tạo tài khoản mới'), centerTitle: true),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              constraints: BoxConstraints(maxWidth: width > 500 ? 500 : width),
              child: Column(
                children: [
                  // const SizedBox(height: 40),
                  // Text(
                  //   "Tạo tài khoản mới",
                  //   style: Theme.of(context).textTheme.headlineSmall,
                  // ),
                  const SizedBox(height: 35),
                  const Row(
                    children: [
                      Text(
                        'Tên tài khoản',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _controllerUsername,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.lightBlueAccent),
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Tên tài khoản không được để trống";
                      } /* else if (_boxAccounts.containsKey(value)) {
                        return "Username is already registered.";
                      } */

                      return null;
                    },
                    onEditingComplete: () => _focusNodeEmail.requestFocus(),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Text(
                        'Địa chỉ email',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _controllerEmail,
                    focusNode: _focusNodeEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.lightBlueAccent),
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Email không được để trống";
                      } else if (!(value.contains('@') &&
                          value.contains('.'))) {
                        return "Email không đúng định dạng";
                      }
                      return null;
                    },
                    onEditingComplete: () => _focusNodePassword.requestFocus(),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Text(
                        'Mật khẩu',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _controllerPassword,
                    obscureText: _obscurePassword,
                    focusNode: _focusNodePassword,
                    keyboardType: TextInputType.visiblePassword,
                    // decoration: InputDecoration(
                    //   labelText: "Password",
                    //   prefixIcon: const Icon(Icons.password_outlined),
                    //   suffixIcon: IconButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           _obscurePassword = !_obscurePassword;
                    //         });
                    //       },
                    //       icon: _obscurePassword
                    //           ? const Icon(Icons.visibility_outlined)
                    //           : const Icon(Icons.visibility_off_outlined)),
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    // ),
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: Colors.grey[200],
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: _obscurePassword
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined)),
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.lightBlueAccent),
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Mật khẩu không được để trống";
                      } else if (value.length < 8) {
                        return "Mật khẩu phải có ít nhất 8 kí tự.";
                      }
                      return null;
                    },
                    onEditingComplete: () =>
                        _focusNodeConfirmPassword.requestFocus(),
                  ),
                  const SizedBox(height: 10),
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
                    controller: _controllerConFirmPassword,
                    obscureText: _obscureConfirmPassword,
                    focusNode: _focusNodeConfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    // decoration: InputDecoration(
                    //   labelText: "Confirm Password",
                    //   prefixIcon: const Icon(Icons.password_outlined),
                    //   suffixIcon: IconButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           _obscureConfirmPassword = !_obscureConfirmPassword;
                    //         });
                    //       },
                    //       icon: _obscureConfirmPassword
                    //           ? const Icon(Icons.visibility_outlined)
                    //           : const Icon(Icons.visibility_off_outlined)),
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    // ),
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: Colors.grey[200],
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          icon: _obscureConfirmPassword
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined)),
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.lightBlueAccent),
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Mật khẩu xác nhận không được để trống";
                      } else if (value != _controllerPassword.text) {
                        return "Mật khẩu xác nhận không khớp";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 36),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final username = _controllerUsername.text.trim();
                            final password = _controllerPassword.text.trim();
                            final email = _controllerEmail.text.trim();
                            loginController.register(RegisterModel(
                                username: username,
                                email: email,
                                password: password));
                          }
                          // if (_formKey.currentState?.validate() ?? false) {
                          //   // _boxAccounts.put(
                          //   //   _controllerUsername.text,
                          //   //   _controllerConFirmPassword.text,
                          //   // );

                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       width: 200,
                          //       backgroundColor:
                          //           Theme.of(context).colorScheme.secondary,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       behavior: SnackBarBehavior.floating,
                          //       content: const Text("Registered Successfully"),
                          //     ),
                          //   );

                          //   _formKey.currentState?.reset();

                          //   Navigator.pop(context);
                          // }
                        },
                        child: const Text("Đăng ký"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Bạn đã có tài khoản?"),
                          TextButton(
                            onPressed: () => Get.back(),
                            // onPressed: () {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       width: 200,
                            //       backgroundColor:
                            //           Theme.of(context).colorScheme.secondary,
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //       behavior: SnackBarBehavior.floating,
                            //       content: const Text("Registered Successfully"),
                            //     ),
                            //   );
                            // },
                            child: const Text("Đăng nhập"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    super.dispose();
  }
}
