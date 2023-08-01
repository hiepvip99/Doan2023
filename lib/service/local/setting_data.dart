import 'package:shared_preferences/shared_preferences.dart';

class SettingData {
  static const _keyTheme = 'theme';
  Future<void> setTheme(int mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyTheme, mode);
  }

  Future<int?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTheme);
  }
}
