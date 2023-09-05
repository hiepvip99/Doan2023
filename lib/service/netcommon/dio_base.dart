// import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart';

// import '../../services/common/impl/user_service_impl.dart';
import 'dio_curl_interceptor.dart';

///Create DioBase
class DioBase {
  ///GetDio
  Dio getDio() {
    final _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {},
      ),
    );
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (response, handler) {
      // DialogCommon.dismiss();
      return handler.next(response);
    }, onError: (DioException e, handler) {
      if (e.response?.statusCode == 401) {
        // Get.find<UserServiceImpl>().logout();
      }
      return handler.next(e);
    }));
    _dio.interceptors.add(DioCurlInterceptor());
    // _dio.interceptors.add(CookieManager(CookieJar()));
    return _dio;
  }
}
