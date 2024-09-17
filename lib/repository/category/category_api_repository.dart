import 'category_repository.dart';

abstract class CategoryApiRepository {
  Future<List<CategoryModel>> getCategories();
}