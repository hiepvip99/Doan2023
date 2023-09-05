import 'package:dio/dio.dart';

import 'dio_base.dart';

class DioService {
  final Dio _dio = DioBase().getDio();

  Dio get() {
    // final _session = SharePreferenceProvider.getCookie();
    // if (_session.isNotEmpty) {
    //   _dio.options.headers = {'Cookie': 'pocket_emergency_session=$_session'};
    // }

    return _dio;
  }

  void removeToken() {
    _dio.options.headers = {};
  }
}
