import 'package:my_app/model/restaurant_category_model.dart';
import 'package:my_app/model/restaurant_details_model.dart';
import 'package:my_app/model/restaurant_model.dart';

abstract class RestaurantHttpRepository {
  Future<List<RestaurantModel>> getAllRestaurant();
  Future<List<RestaurantCategoryModel>> getAllRestaurantCategory();
  Future<RestaurantDetailsModel> getRestaurantDetails(String id);
    Future<List<RestaurantDetailsModel>> getAllRestaurantWithQuery(String query);
}
