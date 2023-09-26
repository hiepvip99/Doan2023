import 'package:get/get.dart';

import 'ui/page/home/admin/home_admin_binding.dart';
import 'ui/page/home/admin/home_admin_view.dart';
import 'ui/page/home/user/home_user.dart';
import 'ui/page/login/login_view.dart';
import 'ui/page/login/login_binding.dart';

final List<GetPage> appPage = [
  GetPage(
    name: HomeAdmin.route,
    page: () => HomeAdmin(),
    binding: HomeAdminBinding(),
  ),
  GetPage(
    name: HomeUser.route,
    page: () => HomeUser(),
    binding: HomeAdminBinding(),
  ),
  GetPage(
    name: Login.route,
    page: () => const Login(),
    binding: LoginBinding(),
  ),
];
