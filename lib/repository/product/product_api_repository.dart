import 'product_repository.dart';

abstract class ProductApiRepository {
  Future<ProductModel> getAllProducts(String category);
  Future<ProductModel> getAllProductsAccordingTitle(String title);
}
