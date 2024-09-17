
import 'brand_repository.dart';

class BrandHttpRepository extends BrandApiRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();
  @override
  Future<List<BrandModel>> getAllBrand() async {
    try {
      final response = await baseApiServices.getGetApiResponse(Urls.brandUrl);
      final data = response as List;
      return data.map((e) => BrandModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
