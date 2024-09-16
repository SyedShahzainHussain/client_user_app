import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_app/config/url.dart';

class AuthInterceptors implements Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('ERROR[${err.response}] => PATH: ${err.requestOptions.path}');
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final modifiedOptions = options.copyWith(
      validateStatus: (status) =>
          status != null && status >= 200 && status < 500,
      baseUrl: Urls.baseUrl,
    );
    handler.next(modifiedOptions);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('RESPONSE[${response.statusCode}] => PATH: ${response.data}');
    }
    handler.next(response);
  }
}
