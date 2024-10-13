import 'package:my_app/model/restaurant_model.dart';

abstract class RestaurantHttpRepository {
  Future<List<RestaurantModel>> getAllRestaurant();
}
