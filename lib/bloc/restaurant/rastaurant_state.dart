import 'package:equatable/equatable.dart';
import 'package:my_app/data/response/response.dart';
import 'package:my_app/model/restaurant_category_model.dart';
import 'package:my_app/model/restaurant_details_model.dart';
import 'package:my_app/model/restaurant_model.dart';

class RestaurantState extends Equatable {
  final ApiResponse<List<RestaurantModel>> restaurantList;
  final ApiResponse<List<RestaurantCategoryModel>> restaurantCategoryList;
  final ApiResponse<RestaurantDetailsModel> restaurantDetailsList;
  final ApiResponse<List<RestaurantDetailsModel>> getAllRestaurantWithQuery;

  const RestaurantState(
      {required this.restaurantList,
      required this.restaurantCategoryList,
      required this.restaurantDetailsList,
      required this.getAllRestaurantWithQuery});

  RestaurantState copyWith(
      {ApiResponse<List<RestaurantModel>>? restaurantList,
      ApiResponse<List<RestaurantCategoryModel>>? restaurantCategoryList,
      ApiResponse<RestaurantDetailsModel>? restaurantDetailsList,
      ApiResponse<List<RestaurantDetailsModel>>? getAllRestaurantWithQuery}) {
    return RestaurantState(
      restaurantList: restaurantList ?? this.restaurantList,
      restaurantCategoryList:
          restaurantCategoryList ?? this.restaurantCategoryList,
      restaurantDetailsList:
          restaurantDetailsList ?? this.restaurantDetailsList,
      getAllRestaurantWithQuery:
          getAllRestaurantWithQuery ?? this.getAllRestaurantWithQuery,
    );
  }

  @override
  List<Object?> get props => [
        restaurantList,
        restaurantCategoryList,
        restaurantDetailsList,
        getAllRestaurantWithQuery
      ];
}
