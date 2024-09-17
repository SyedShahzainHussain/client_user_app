import 'brand_repository.dart';

abstract class BrandApiRepository {
  Future<List<BrandModel>> getAllBrand();
}
