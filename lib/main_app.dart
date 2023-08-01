import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/service/local/setting_data.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';
import 'package:web_app/ui/home/admin/home_admin_view.dart';
import 'package:web_app/ui/home/home.dart';

import 'app_page.dart';
import 'config_theme.dart';
import 'ui/login/login.dart';
// import 'ui/product/product_s.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final RxInt modeTheme = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: () => initApp(),
      getPages: appPage,
      themeMode: getTheme(modeTheme.value),
      darkTheme: darkTheme,
      theme: lightTheme,
      initialRoute: HomeAdmin.router,
      // home: const Home(),
    );
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

  void initApp() async {
    inject();

    /// 0 light 1 dark 2 system
    modeTheme.value = await SettingData().getTheme() ?? 0;
  }

  void inject() {
    Get.lazyPut(() => DialogCommon());
  }
}
