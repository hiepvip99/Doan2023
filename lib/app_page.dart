import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/search/search_binding.dart';

import 'ui/page/home/admin/home_admin_binding.dart';
import 'ui/page/home/admin/home_admin_view.dart';
import 'ui/page/home/user/home_user.dart';
import 'ui/page/home/user/home_user_binding.dart';
import 'ui/page/home/user/product/product_binding.dart';
import 'ui/page/home/user/product/product_view.dart';
import 'ui/page/home/user/search/search_view.dart';
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
    binding: HomeUserBinding(),
  ),
  GetPage(
    name: Login.route,
    page: () => const Login(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: SearchView.route,
    page: () => const SearchView(),
    binding: SearchBinding(),
  ),
  GetPage(
    name: ProductView.route,
    page: () => ProductView(),
    binding: ProductBinding(),
  ),
];
