import 'package:get/get.dart';
import 'package:web_app/service/network/customer_service.dart';

import '../../../../../model/network/notification_model.dart';
import '../../../../../service/local/save_data.dart';

class NotificationViewModel extends GetxController {
  RxList<NotificationModel> notificationList = RxList();

  CustomerService customerService = CustomerService();

  final accountId = DataLocal.getAccountId();
  RxBool loading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotification();
  }

  Future<void> getNotification() async {
    loading.value = true;
    customerService.getNotification(accountId: accountId).then((value) {
      if (value?.data != null) {
        notificationList.value = value!.data!;
      }
    });
    loading.value = false;
  }
}
