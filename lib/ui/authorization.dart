import 'package:get/get.dart';
import 'package:web_app/service/local/save_data.dart';

class Authorization {
  Authorization._();

  static bool isLogged() {
    final accountID = DataLocal.getAccountId();
    return accountID != null;
  }

  static int checkRole() {
    final role = DataLocal.getRole() ?? -1;
    return role;
  }
}
