abstract class BaseApiServices {
  // Todo Get Api
  Future<dynamic> getGetApiResponse(
    String url, [
    Map<String, dynamic>? queryParameters,
    dynamic body,
  ]);

  // Todo Post Api

  Future<dynamic> getPostApiResponse(String url, dynamic body);




      
}
