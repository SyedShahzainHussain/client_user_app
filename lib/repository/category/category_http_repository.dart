import 'category_repository.dart';

class CategoryHttpRepository extends CategoryApiRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await baseApiServices
          .getGetApiResponse(Urls.categoryUrl);
      final data = response as List;
      return data.map((category) => CategoryModel.fromJson(category)).toList();
    } catch (_) {
      rethrow;
    }
  }
}
