import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataLocal {
  // DataLocal._();
  static const String _keyAccountId = 'account_id';
  static const String _keyRole = 'role';
  static final _sharePreference = Get.find<SharedPreferences>();

  static Future<void> saveRole(int role) async {
    await _sharePreference.setInt(_keyRole, role);
  }

  static int? getRole() {
    return _sharePreference.getInt(_keyRole);
  }

  static Future<void> saveAccountId(String accountId) async {
    await _sharePreference.setString(_keyAccountId, accountId);
  }

  static String? getAccountId() {
    return _sharePreference.getString(_keyAccountId);
  }

  static Future<bool> deleteAccount() async {
    // await _sharePreference.setString(_keyAccountId, '');
    await _sharePreference.remove(_keyRole);
    return await _sharePreference.remove(_keyAccountId);
  }
}

/*
DataLocal dataLocal = DataLocal();

/// Lưu trữ ID tài khoản
dataLocal.saveAccountId('123456');

/// Lấy ID tài khoản
String? accountId = await dataLocal.getAccountId();
print(accountId); // In ra: 123456
*/