import 'dart:io';

abstract class BaseApiServices {
  // Todo Get Api
  Future<dynamic> getGetApiResponse(
    String url, [
    Map<String, dynamic>? queryParameters,
    dynamic body,
  ]);

  // Todo Post Api

  Future<dynamic> getPostApiResponse(String url, dynamic body);

  // Todo Put Api
  Future<dynamic> getPutApiResponse(String url, dynamic body);

  // Todo Form Data
  Future<dynamic> putFormData({
    required String url,
    required Map<String, dynamic> additionalData,
    bool? singleFile,
    File? image,
    List<File>? images,
  });
}
