// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class OrderManagerViewModel extends GetxController {
  RxList<OrderModel> listOrder = RxList();
  @override
  void onInit() {
    super.onInit();
    listOrder.value = [
      OrderModel(
          id: 0,
          accountId: 0,
          date: '2023-08-10 15:35:40',
          status: 0,
          totalPrice: 9100000000),
      OrderModel(
          id: 2,
          accountId: 2,
          date: '2023-08-10 15:35:40',
          status: 0,
          totalPrice: 1000099900),
      OrderModel(
          id: 3,
          accountId: 3,
          date: '2023-08-10 15:35:40',
          status: 0,
          totalPrice: 2222222),
      OrderModel(
          id: 4,
          accountId: 4,
          date: '2023-08-10 15:35:40',
          status: 0,
          totalPrice: 777777777754),
    ];
  }
}

class OrderModel {
  int? id;
  int? accountId;
  String? date;
  int? totalPrice;
  int? status;
  OrderModel({
    this.id,
    this.accountId,
    this.date,
    this.totalPrice,
    this.status,
  });
}
