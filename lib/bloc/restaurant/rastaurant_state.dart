import 'package:equatable/equatable.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/model/restaurant_model.dart';

class RestaurantState extends Equatable {
  final PostApiStatus postApiStatus;
  final List<RestaurantModel> restaurantList;

  const RestaurantState(
      {required this.postApiStatus, this.restaurantList = const []});

  RestaurantState copyWith(
      {PostApiStatus? postApiStatus, List<RestaurantModel>? restaurantList}) {
    return RestaurantState(
        postApiStatus: postApiStatus ?? this.postApiStatus,
        restaurantList: restaurantList ?? this.restaurantList);
  }

  @override
  List<Object?> get props => [postApiStatus, restaurantList];
}
