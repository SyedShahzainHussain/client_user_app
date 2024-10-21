import 'package:equatable/equatable.dart';
import 'package:my_app/data/response/response.dart';
import 'package:my_app/model/restaurant_model.dart';

class RestaurantState extends Equatable {
  final ApiResponse<List<RestaurantModel>> restaurantList;

  const RestaurantState({required this.restaurantList});

  RestaurantState copyWith(
      {ApiResponse<List<RestaurantModel>>? restaurantList}) {
    return RestaurantState(
        restaurantList: restaurantList ?? this.restaurantList);
  }

  @override
  List<Object?> get props => [restaurantList];
}
