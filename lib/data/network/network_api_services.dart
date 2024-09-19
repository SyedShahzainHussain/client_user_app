import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_app/data/exception.dart';
import 'package:my_app/data/network/base_api_services.dart';
import 'package:my_app/data/network/interceptors_services.dart';

class NetworkApiServices extends BaseApiServices {
  final Dio _dio;

  NetworkApiServices() : _dio = Dio() {
    _dio.interceptors.add(AuthInterceptors());
  }

  @override
  Future getGetApiResponse(
    String url, [
    Map<String, dynamic>? queryParameters,
    dynamic body,
  ]) async {
    dynamic responseJson;
    try {
      final response = await _dio.get(
        url,
        data: body,
        queryParameters: queryParameters,
      );
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(
    String url,
    dynamic body,
  ) async {
    dynamic responseJson;
    try {
      final response = await _dio.post(
        url,
        data: body,
      );
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, body) async {
    dynamic responseJson;
    try {
      final response = await _dio.put(
        url,
        data: body,
      );
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
      case 401:
      case 403:
      case 404:
      case 500:
        // Extract message from response body if available
        String errorMessage = response.data['message'] ??
            response.statusMessage ??
            'An error occurred';
        throw errorMessage;
      default:
        throw FetchDataException(
            'Error occurred with status code ${response.statusCode}');
    }
  }
}
