import 'product_repository.dart';

class ProductHttpRepository extends ProductApiRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();
  @override
  Future<ProductModel> getAllProducts(String category) async {
    try {
      final response = await baseApiServices
          .getGetApiResponse(Urls.productUrl, {"category": category});
      final data = response;
      return ProductModel.fromJson(data);
    } catch (e) {

      rethrow;
    }
  }
}
