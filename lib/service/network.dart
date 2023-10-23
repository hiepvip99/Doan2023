import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;
import 'package:web_app/constant.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';

import 'base_entity.dart';

enum HttpMethod { get, post, put, delete, path }

// class NetworkCommon {
//   final Dio _dio = Dio();

//   Future<T?> callNetworkApi<T extends BaseEntity>(
//       T Function(Map<dynamic, dynamic> e) convert, String path,
//       {required HttpMethod method,
//       data,
//       bool? onBackground,
//       queryParameters,
//       bool? showLoading = true}) async {
//     DialogCommon dialogCommon = DialogCommon();
//     dialogCommon.showLoadingDialog();
//     try {
//       _dio.options.headers['X-Request-By'] = 'api';
//       if (data is FormData) {
//         _dio.options.headers['Content-Type'] = 'multipart/form-data';
//       } else {
//         _dio.options.headers['Content-Type'] = 'application/json';
//       }
//       dynamic response;
//       switch (method) {
//         case HttpMethod.get:
//           print('http_request: get: ' + domain + path);
//           response =
//               await _dio.get(domain + path, queryParameters: queryParameters);
//           break;
//         case HttpMethod.post:
//           print('http_request: post: ' + domain + path);
//           response = await _dio.post(domain + path, data: data);
//           break;
//         case HttpMethod.put:
//           print('http_request: put: ' + domain + path);
//           response = await _dio.put(domain + path, data: data);
//           break;
//         case HttpMethod.delete:
//           print('http_request: delete: ' + domain + path);
//           response = await _dio.delete(domain + path, data: data);
//           break;
//         case HttpMethod.path:
//           print('http_request: path: ' + domain + path);
//           response = await _dio.patch(domain + path, data: data);
//           break;
//       }
//       print(response);
//       return _getDocument(json.decode(response), convert);
//     } catch (e) {
//       throw e;
//       return null;
//     } finally {
//       dialogCommon.dismiss();
//     }
//   }

//   Future<T?> _getDocument<T extends BaseEntity>(
//     Map<String, dynamic>? response,
//     T Function(Map<dynamic, dynamic> e) convert,
//   ) async {
//     if (response == null) {
//       return null;
//     }
//     final listObj = _decode<T>(response, convert);
//     return listObj;
//   }

//   T _decode<T extends BaseEntity>(Map<String, dynamic> document,
//       T Function(Map<dynamic, dynamic> e) convert) {
//     try {
//       final json = document;
//       return convert(json);
//     } on Exception {
//       rethrow;
//     }
//   }
// }
