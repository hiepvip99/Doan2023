import 'package:get/get.dart';

import 'product_review_view_model.dart';

class ProductReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductReviewModel());
  }
}
