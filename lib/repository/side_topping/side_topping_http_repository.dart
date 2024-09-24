
import 'side_topping_repository.dart';

class SideToppingHttpRepository extends SideToppingApiRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();
  @override
  Future<List<SideToppins>> getAllSideToppings() async {
    try {
      final response = await baseApiServices.getGetApiResponse(Urls.sideToppingUrl);
      final data = response as List;
      return data.map((data) => SideToppins.fromJson(data)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
