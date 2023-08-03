import 'package:get/get.dart';
import 'package:web_app/ui/page/home/admin/home_admin_binding.dart';

import 'ui/page/home/admin/home_admin_view.dart';

final List<GetPage> appPage = [
  GetPage(
    name: HomeAdmin.router,
    page: () => HomeAdmin(),
    binding: HomeAdminBinding(),
  ),
];
