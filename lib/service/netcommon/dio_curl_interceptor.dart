import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class DioCurlInterceptor extends InterceptorsWrapper {
  // final _logger = Get.find<SlackLogger>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      log('------ BEGIN REQUEST ------');
      log(options.toCurlCmd());
      log('------ END REQUEST ------');
    } catch (e) {
      log('Create CURL failure!! - $e');
    }
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final data = response.data;
    _prettyPrintJson(data, response.requestOptions);
    // log(response.toString());
    return handler.next(response);
  }

  void _prettyPrintJson(response, RequestOptions options) {
    // try {
    //   log('------ BEGIN REQUEST ------');
    //   log(options.toCurlCmd());
    //   log('------ END REQUEST ------');
    //   // log(response.toString());
    //   // log('------ RESPONSE REQUEST ------');
    // } catch (e) {
    //   log('Create CURL failure!! - $e');
    // }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message =
        '------ BEGIN REQUEST ------\n${err.requestOptions.toCurlCmd()}\nResult: ${err.response.toString()}\n------ END REQUEST ------ \n\n\n\n\n\n\n\n';
    // _logger.logging(message);
    super.onError(err, handler);
  }
}

extension Curl on RequestOptions {
  String toCurlCmd() {
    String cmd = 'curl';

    final String header = this
        .headers
        .map((key, value) {
          if (key == 'content-type' &&
              value.toString().contains('multipart/form-data')) {
            value = 'multipart/form-data;';
          }
          return MapEntry(key, "--header '$key: $value'");
        })
        .values
        .join(' ');
    String url = '$baseUrl$path';
    if (this.queryParameters.length > 0) {
      final String query = this
          .queryParameters
          .map((key, value) {
            return MapEntry(key, '$key=$value');
          })
          .values
          .join('&');

      url += (url.contains('?')) ? query : '?$query';
    }
    if (this.method == 'GET') {
      cmd += " $header '$url'";
    } else {
      final Map<String, dynamic> files = {};
      String postData = "-d ''";
      if (data != null) {
        if (data is FormData) {
          final fdata = data as FormData;
          fdata.files.forEach((element) {
            final MultipartFile file = element.value;
            files[element.key] = '@${file.filename}';
          });
          fdata.fields.forEach((element) {
            files[element.key] = element.value;
          });
          if (files.length > 0) {
            postData = files
                .map((key, value) => MapEntry(key, "--form '$key=\"$value\"'"))
                .values
                .join(' ');
          }
        } else if (data is Map<String, dynamic>) {
          files.addAll(data as Map<String, dynamic>);

          if (files.length > 0) {
            postData = "-d '${json.encode(files).toString()}'";
          }
        } else {
          postData = "-d '${data.toString()}'";
        }
      }

      final String method = this.method.toString();
      cmd += " --location '$url' -X $method $header $postData";
    }

    return cmd;
  }
}
