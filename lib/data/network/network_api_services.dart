import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_app/data/exception.dart';
import 'package:my_app/data/network/base_api_services.dart';
import 'package:my_app/data/network/interceptors_services.dart';
import 'package:http_parser/http_parser.dart' as ht;

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

  @override
  Future<dynamic> putFormData({
    required String url,
    required Map<String, dynamic> additionalData,
    bool? singleFile,
    List<File>? images,
    File? image,
  }) async {
    dynamic responseJson;
    try {
      FormData formData = FormData();

      // Add image to formData only if it is not null
      if (singleFile == true && image != null) {
        formData.files.add(MapEntry(
          'image', // the name of the field
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split("/").last,
            contentType: ht.MediaType(
              'image', // Type of media
              image.path.split('.').last, // The file extension (e.g., jpg, png)
            ),
          ),
        ));
      } else if (images != null && images.isNotEmpty) {
        // If you're using multiple files
        for (var img in images) {
          formData.files.add(MapEntry(
            'image[]', // the name of the field
            await MultipartFile.fromFile(
              img.path,
              contentType: ht.MediaType(
                'image', // Type of media
                img.path.split('.').last, // The file extension (e.g., jpg, png)
              ),
            ),
          ));
        }
      }

      // Add additional fields to formData
      additionalData.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      final response = await _dio.put(url, data: formData);
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostEmptyBodyApiResponse(String url,
      [Map<String, String>? headers]) async {
    dynamic responseJson;
    try {
      final response = await _dio.post(
        url,
        options: Options(headers: headers),
      );
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future deletePostApiResponse(String url,
      [dynamic body, Map<String, dynamic>? headers]) async {
    dynamic returnReponse;
    try {
      final response = await _dio.delete(
        url,
        data: body,
        options: Options(headers: headers),
      );
      returnReponse = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return returnReponse;
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
