import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/page/home/admin/home_admin_view.dart';
import 'package:web_app/ui/page/home/user/home_user.dart';

import 'app_page.dart';
import 'config_theme.dart';
import 'service/local/setting_data.dart';
import 'ui/dialog/dialog_common.dart';
import 'ui/page/login/login_view.dart';
// import 'ui/product/product_s.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key, required this.role});

  final RxInt modeTheme = 0.obs;
  final int role;

  String? getInitRoute() {
    switch (role) {
      case -1:
        return Login.route;
      case 0:
        return Login.route;
      case 1:
        return HomeUser.route;
      default:
        return Login.route;
    }
  }

  ThemeMode getTheme(int value) {
    switch (value) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      case 2:
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }

  void onInit() async {
    inject();

    /// 0 light 1 dark 2 system
    modeTheme.value = await SettingData().getTheme() ?? 0;
  }

  void inject() {
    Get.lazyPut(() => DialogCommon());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: () => onInit(),
      getPages: appPage,
      themeMode: getTheme(modeTheme.value),
      darkTheme: darkTheme,
      theme: lightTheme,
      initialRoute: getInitRoute(),
      // home: const Home(),
    );
  }
}
