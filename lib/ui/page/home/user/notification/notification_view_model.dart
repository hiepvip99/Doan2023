import 'package:get/get.dart';
import 'package:web_app/service/network/customer_service.dart';

import '../../../../../model/network/notification_model.dart';

class NotificationViewModel extends GetxController {
  RxList<NotificationModel> notificationList = RxList();

  CustomerService customerService = CustomerService();

  final accId = 3;
  RxBool loading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotification();
  }

  Future<void> getNotification() async {
    loading.value = true;
    customerService.getNotification(accountId: accId).then((value) {
      if (value?.data != null) {
        notificationList.value = value!.data!;
      }
    });
    loading.value = false;
  }
}
