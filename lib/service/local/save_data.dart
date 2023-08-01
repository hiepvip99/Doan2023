import 'package:shared_preferences/shared_preferences.dart';

class DataLocal {
  static const String _keyAccountId = 'account_id';
  static const String _keyRole = 'role';

  Future<void> saveRole(int role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyRole, role);
  }

  Future<int?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyRole);
  }

  Future<void> saveAccountId(String accountId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccountId, accountId);
  }

  Future<String?> getAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccountId);
  }

  Future<void> deleteAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccountId, '');
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