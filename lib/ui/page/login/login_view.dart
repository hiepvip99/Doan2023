import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_app/ui/page/login/login_controller.dart';
// import 'package:hive_flutter/hive_flutter.dart';

import '../../component_common/textfield_beautiful.dart';
import '../home/admin/home_admin_view.dart';
import '../home/user/home_user.dart';
import '../signup/signup.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);
  static const route = '/Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeButton = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _obscurePassword = true;
  // final Box _boxLogin = Hive.box("login");
  // final Box _boxAccounts = Hive.box("accounts");
  late LoginController _controller;
  @override
  void initState() {
    super.initState();
    _controller = Get.find<LoginController>();
    // if (_controller.statusLogin.value) {
    //   if (_controller.isRoleAdmin.value) {
    //     Get.offNamed(HomeAdmin.route);
    //   } else {
    //     Get.offNamed(HomeUser.route);
    //   }
    //   // return Home();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: width > 500 ? 500 : width),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 75),
                    Text(
                      "Agiay.vn",
                      style: GoogleFonts.pacifico(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    // const SizedBox(height: 10),
                    // Text(
                    //   "Đăng nhập vào tài khoản của bạn",
                    //   style: Theme.of(context).textTheme.bodyMedium,
                    // ),
                    const SizedBox(height: 48),
                    const Row(
                      children: [
                        Text(
                          'Tài khoản',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Stack(
                      children: [
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
                              borderSide: const BorderSide(
                                  color: Colors.lightBlueAccent),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              // borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onEditingComplete: () =>
                              _focusNodePassword.requestFocus(),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng nhập tên tài khoản";
                            }

                            return null;
                          },
                        ),
                      ],
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
                      focusNode: _focusNodePassword,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
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
                      onEditingComplete: () => _focusNodeButton.requestFocus(),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập mật khẩu";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Quên mật khẩu?",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // const Divider(),
                    // const SizedBox(height: 18),
                    Column(
                      children: [
                        ElevatedButton(
                          focusNode: _focusNodeButton,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              unawaited(_controller.loginApp(
                                  _controllerUsername.text.trim(),
                                  _controllerPassword.text.trim()));
                              // _boxLogin.put("loginStatus", true);
                              // _boxLogin.put("userName", _controllerUsername.text);

                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return Home();
                              //     },
                              //   ),
                              // );
                            }
                          },
                          child: const Text("Đăng nhập"),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                                child: Text(
                              "Bạn chưa có tài khoản?",
                              overflow: TextOverflow.ellipsis,
                            )),
                            TextButton(
                              onPressed: () {
                                _formKey.currentState?.reset();
                                Get.to(() => const Signup());
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return const Signup();
                                //     },
                                //   ),
                                // );
                              },
                              child: const Text(
                                "Đăng ký",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNodeButton.dispose();
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
