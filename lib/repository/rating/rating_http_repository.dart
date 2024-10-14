import 'package:my_app/config/url.dart';
import 'package:my_app/data/network/base_api_services.dart';
import 'package:my_app/data/network/network_api_services.dart';
import 'package:my_app/repository/rating/rating_api_repository.dart';

class RatingHttpRepository extends RatingApiRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();
  @override
  Future<void> createRating(body) async {
    try {
      await baseApiServices.getPostApiResponse(Urls.createRating, body);
    } catch (e) {
      rethrow;
    }
  }
}
