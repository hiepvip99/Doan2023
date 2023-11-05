import 'package:get/get.dart';

import '../../../../../model/network/customer_model.dart';
import '../../../../../model/network/order_manager_model.dart';
import '../../../../../service/network/order_service.dart';

class MyReviewViewModel extends GetxController {
  RxInt currentPage = 1.obs;
  int step = 10;
  Rx<Customer> customerInfo = Rx(Customer());
  RxList<Review> reviewList = RxList();
  OrderService orderService = OrderService();

  Future<void> getMyReview() async {
    await orderService
        .getReview(
            customerId: customerInfo.value.id,
            page: currentPage.value,
            step: step)
        .then((value) {
      reviewList.value = value?.reviews ?? [];
      // averageRating.value = value?.averageRating ?? 5.0;
      // totalRating.value = value?.totalRating ?? 0;
      // ratingCounts.value = value?.ratingCounts ?? RatingCounts();
    });
  }

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments;
    if (data is Customer) {
      customerInfo.value = data;
    }
    getMyReview();
  }
}
