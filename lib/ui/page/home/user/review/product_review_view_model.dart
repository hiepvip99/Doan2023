import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/model/network/customer_model.dart';
import 'package:web_app/service/local/save_data.dart';
import 'package:web_app/service/network/customer_service.dart';

import '../../../../../model/network/order_manager_model.dart';
import '../../../../../service/network/order_service.dart';

class ProductReviewModel extends GetxController {
  CustomerService customerService = CustomerService();
  OrderService orderService = OrderService();
  Customer customer = Customer();

  Future<void> getCustomer() async {
    final accountId = DataLocal.getAccountId();
    customerService
        .getCustomerById(accountId: accountId)
        .then((value) => customer = value ?? Customer());
  }

  Future<void> submitReview(Review review) async {
    orderService.addReview(review).then((value) {
      if (value?.statusCode == 200) {
        Get.showSnackbar(const GetSnackBar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          message: 'Bạn đã đánh giá thành công',
          title: 'Đánh giá thành công rồi',
          duration: Duration(seconds: 2),
        ));
      } else {
        Get.showSnackbar(const GetSnackBar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          message: 'Đã có lỗi xảy ra',
          title: 'Đánh giá sản phẩm thất bại',
          duration: Duration(seconds: 2),
        ));
      }
    });
    Get.back();
    // Gửi đánh giá sản phẩm đi và xử lý dữ liệu ở đây
    // print('Đánh giá: $_reviewText');
    // print('Điểm đánh giá: $_rating');
  }

  @override
  void onInit() {
    super.onInit();
    getCustomer();
  }
}
