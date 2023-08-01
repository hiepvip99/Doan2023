import 'package:get/get.dart';
import 'package:web_app/ui/home/admin/home_admin_binding.dart';

import 'ui/home/admin/home_admin_view.dart';

final List<GetPage> appPage = [
  GetPage(
    name: HomeAdmin.router,
    page: () => HomeAdmin(),
    binding: HomeAdminBinding(),
  ),
];
