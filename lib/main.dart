import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

import 'injection.dart';
import 'main_app.dart';
import 'ui/authorization.dart';

void main() {
  // await _initHive();
  initApp();
}

Future<void> initApp() async {
  // final WidgetsBinding widgetsBinding =
  //     WidgetsFlutterBinding.ensureInitialized();
  await Injection.instance.injection();
  if (Authorization.isLogged()) {
    final role = Authorization.checkRole();
    runApp(MainApp(
      role: role,
    ));
  }
}

// Future<void> checkStatusAndRoleLogin() async {
//   DataLocal dataLocal = DataLocal();
//   RxBool statusLogin = false.obs;
//   RxBool isRoleAdmin = false.obs;
//   final accountId = await dataLocal.getAccountId();
//   final role = await dataLocal.getRole();
//   if (accountId != '') {
//     statusLogin.value = true;
//     // -1 chua login
//     // 0 admin
//     // 1 user
//     if (role != null) {
//       if (role == 0) {
//         isRoleAdmin.value = true;
//       } else {
//         isRoleAdmin.value = false;
//       }
//     }
//   } else {
//     statusLogin.value = false;
//   }

//   final accId = await dataLocal.getAccountId() ?? '';
//   final role = await dataLocal.getRole() ?? -1;

//   if (accId.trim().isNotEmpty && role > -1) {
//     if (role == 0) {
//       Get.offNamed(HomeAdmin.route);
//     } else {
//       Get.offNamed(HomeUser.route);
//     }
//   }
// }

// Future<void> _initHive() async {
//   await Hive.initFlutter();
//   await Hive.openBox("login");
//   await Hive.openBox("accounts");
// }
