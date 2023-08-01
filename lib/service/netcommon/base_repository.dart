import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui/dialog/dialog_common.dart';
import '../base_entity.dart';
// import '../config.dart';
// import '../data/network/api_constants.dart';
// import '../data/storage/share_preference_helper/share_preference_constants.dart';
// import '../data/storage/store_global.dart';
// import '../models/network/base_entity.dart';
import '../network.dart';
// import '../presentations/components/dialog_common.dart';
// import '../services/common/dio_service.dart';
// import '../utilities/enums.dart';
// import '../utilities/function_helper.dart';
// import 'api_concern_network.dart';

bool haveShowDialog = false;

abstract class BaseRepositoryInterface {
  int get timeoutInterval;

  Future<T?> queryByPath<T extends BaseEntity>(
      T Function(Map<dynamic, dynamic> e) convert,
      {dynamic data});
}

class BaseRepository extends BaseRepositoryInterface {
  BaseRepository({
    required this.url,
    required this.method,
  });

  late String url;
  late HttpMethod method;
  late Dio _dio;

  @override
  Future<T?> queryByPath<T extends BaseEntity>(
      T Function(Map<dynamic, dynamic> e) convert,
      {data,
      bool? onBackground,
      queryParameters,
      bool? showLoading = true,
      bool? showError = true}) async {
    DialogCommon dialogCommon = Get.find<DialogCommon>();
    try {
      dynamic response;
      Dio _dio = Dio();
      // _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.headers['X-Request-By'] = 'api';
      if (data is FormData) {
        _dio.options.headers['Content-Type'] = 'multipart/form-data';
      } else {
        _dio.options.headers['Content-Type'] = 'application/json';
      }
      if (!await hasNetwork() && (method != HttpMethod.get)) {
        // if (apiConcernNetwork
        //     .where((element) => url.contains(element.build()))
        //     .isNotEmpty) {
        DialogCommon.showDialogErrorNetwork();
        // }

        return null;
      }
      switch (method) {
        case HttpMethod.get:
          // if (hasNetwork()) {
          if (queryParameters is Map<String, dynamic>?) {
            response = await _dio.get(url, queryParameters: queryParameters);
            // unawaited(saveToCache(url, jsonDecode(response.toString())));
          }
          // } else {
          //   try {
          //     final json = await StoreCommon.storage.get(url);

          //     response = jsonEncode(json);
          //   } catch (e, stackTrace) {
          //     print(e.toString());
          //   }
          // }

          break;
        case HttpMethod.post:
          if (!(onBackground ?? false)) {
            if (showLoading ?? true) {
              dialogCommon.showLoadingDialog();
            }
          }
          response = await _dio.post(url, data: data);
          break;
        case HttpMethod.put:
          response = await _dio.put(url, data: data);
          break;
        case HttpMethod.delete:
          response = await _dio.delete(url, data: data);
          break;
        case HttpMethod.path:
          response = await _dio.patch(url, data: data);
          break;
      }
      if (response == null || response.toString().isEmpty) {
        return null;
      }
      haveShowDialog = false;
      response = jsonDecode(response.toString());

      if (response is Map<String, dynamic>?) {
        return _getDocument(response, convert);
      }
    } catch (e, stackTrace) {
      try {
        if (e is! DioException) {
          return null;
        }
        final res = e.response;
        if (res == null) {
          return null;
        }
        final response = jsonDecode(res.toString()) as Map<String, dynamic?>;
        final status = response['status'];
        if (status is int) {
          final message = response['message'] ?? '';
          if (message is String && message.isNotEmpty && (showError ?? true)) {
            final context = Get.context;
            if (context != null) {
              unawaited(dialogCommon.showAlertDialog(
                  context: context, title: message));
              print(
                  'system error: ${e.requestOptions.uri} _${e.response.toString()} ');
            }
            return null;
          }
        }
        return _getDocument(response, convert);
      } catch (ex) {
        print(ex);
      }
    } finally {
      if ((showLoading ?? true) && (method == HttpMethod.post)) {
        dialogCommon.dismiss();
      }
    }
    return null;
  }

  @override
  // TODO: implement timeoutInterval
  int get timeoutInterval => 30;

  T _decode<T extends BaseEntity>(Map<String, dynamic> document,
      T Function(Map<dynamic, dynamic> e) convert) {
    try {
      final json = document;
      return convert(json);
    } on Exception {
      rethrow;
    }
  }

  Future<T?> _getDocument<T extends BaseEntity>(
    Map<String, dynamic>? response,
    T Function(Map<dynamic, dynamic> e) convert,
  ) async {
    if (response == null) {
      return null;
    }
    final listObj = _decode<T>(response, convert);
    return listObj;
  }
}

Future<bool> hasNetwork() async {
  // if (kDebugMode) {
  //   return true;
  // }
  final ConnectivityResult result = await (Connectivity().checkConnectivity());
  if (result == ConnectivityResult.wifi ||
      result == ConnectivityResult.mobile ||
      result == ConnectivityResult.ethernet) {
    return true;
  }
  return false;
}
