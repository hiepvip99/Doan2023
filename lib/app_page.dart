import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/order/order_binding.dart';

import 'ui/page/home/admin/home_admin_binding.dart';
import 'ui/page/home/admin/home_admin_view.dart';
import 'ui/page/home/user/about_us/about_us.dart';
import 'ui/page/home/user/cart/cart_binding.dart';
import 'ui/page/home/user/home_user.dart';
import 'ui/page/home/user/home_user_binding.dart';
import 'ui/page/home/user/cart/cart_view.dart';
import 'ui/page/home/user/my_order_manager/components/order_success.dart';
import 'ui/page/home/user/my_order_manager/my_order_binding.dart';
import 'ui/page/home/user/my_order_manager/my_order_view.dart';
import 'ui/page/home/user/my_order_manager/order_detail/order_detail_binding.dart';
import 'ui/page/home/user/my_order_manager/order_detail/order_detail_view.dart';
import 'ui/page/home/user/order/order_view.dart';
import 'ui/page/home/user/product/product_binding.dart';
import 'ui/page/home/user/product/product_view.dart';
import 'ui/page/home/user/profile/my_profile/my_profile_binding.dart';
import 'ui/page/home/user/profile/my_profile/my_profile_view.dart';
import 'ui/page/home/user/search/search_binding.dart';
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
    page: () => const HomeUser(),
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
  GetPage(
    name: MyOrderView.route,
    page: () => MyOrderView(),
    binding: MyOrderBinding(),
  ),
  GetPage(
    name: OrderDetailView.route,
    page: () => OrderDetailView(),
    binding: OrderDetailBinding(),
  ),
  GetPage(
    name: ShoppingCartScreen.route,
    page: () => ShoppingCartScreen(),
    binding: CartBinding(),
  ),
  GetPage(
    name: AboutUs.route,
    page: () => const AboutUs(),
  ),
  GetPage(
    name: OrderSuccessScreen.route,
    page: () => const OrderSuccessScreen(),
  ),
  GetPage(
    name: OrderView.route,
    page: () => const OrderView(),
    binding: OrderBinding(),
  ),
  GetPage(
    name: EditProfileScreen.route,
    page: () => const EditProfileScreen(),
    binding: EditProfileBinding(),
  ),
];
