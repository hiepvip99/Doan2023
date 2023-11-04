import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataLocal {
  // DataLocal._();
  static const String _keyAccountId = 'account_id';
  static const String _keyCustomerId = 'customer_id';
  static const String _keyRole = 'role';
  static late final SharedPreferences sharedPreferences;

  static Future<void> saveRole(int role) async {
    await sharedPreferences.setInt(_keyRole, role);
  }

  static int? getRole() {
    return sharedPreferences.getInt(_keyRole);
  }

  static Future<void> saveAccountId(String accountId) async {
    await sharedPreferences.setString(_keyAccountId, accountId);
  }

  static String? getAccountId() {
    return sharedPreferences.getString(_keyAccountId);
  }

  static Future<void> saveCustomerId(int customerId) async {
    await sharedPreferences.setInt(_keyCustomerId, customerId);
  }

  static String? getCustomerId() {
    return sharedPreferences.getString(_keyCustomerId);
  }

  static Future<bool> deleteAccount() async {
    // await sharedPreferences.setString(_keyAccountId, '');
    await sharedPreferences.remove(_keyRole);
    return await sharedPreferences.remove(_keyAccountId);
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