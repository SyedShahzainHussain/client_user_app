import 'package:my_app/config/url.dart';
import 'package:my_app/data/network/base_api_services.dart';
import 'package:my_app/data/network/network_api_services.dart';
import 'package:my_app/model/restaurant_category_model.dart';
import 'package:my_app/model/restaurant_details_model.dart';
import 'package:my_app/model/restaurant_model.dart';
import 'package:my_app/repository/restaurant/restaurant_http_repository.dart';

class RestaurantRepository extends RestaurantHttpRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();
  @override
  Future<List<RestaurantModel>> getAllRestaurant() async {
    try {
      final response = await baseApiServices.getGetApiResponse(Urls.resturant);
      final data = response as List;
      return data.map((e) => RestaurantModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RestaurantCategoryModel>> getAllRestaurantCategory() async {
    try {
      final response =
          await baseApiServices.getGetApiResponse(Urls.resturantCategory);
      final data = response as List;
      return data.map((e) => RestaurantCategoryModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RestaurantDetailsModel> getRestaurantDetails(String id) async {
    try {
      final response =
          await baseApiServices.getGetApiResponse("${Urls.resturant}/$id");
      return RestaurantDetailsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
