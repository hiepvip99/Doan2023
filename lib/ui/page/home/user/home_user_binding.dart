import 'package:get/get.dart';

import 'favorite/favorite_view_model.dart';
import 'home_user_controller.dart';
import 'notification/notification_view_model.dart';
import 'profile/profile_view_model.dart';
import 'review/product_review_view_model.dart';

class HomeUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeUserController());
    Get.lazyPut(() => FavoriteViewModel(), fenix: true);
    Get.lazyPut(() => NotificationViewModel(), fenix: true);
    Get.lazyPut(() => ProfileViewModel());
    Get.lazyPut(() => ProductReviewModel());
  }
}
