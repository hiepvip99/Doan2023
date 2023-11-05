import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/my_review/my_review_view_model.dart';

class MyReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyReviewViewModel());
  }
}
