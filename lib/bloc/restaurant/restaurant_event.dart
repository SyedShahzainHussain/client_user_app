import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchRestaurant extends RestaurantEvent {
  FetchRestaurant();
}

class RestaurantCategoryApi extends RestaurantEvent {
  RestaurantCategoryApi();
}

class RestaurantDetails extends RestaurantEvent {
  final String id;
  RestaurantDetails({required this.id});
}



class GetAllRestaurantWithQuery extends RestaurantEvent{
  final String query;
   GetAllRestaurantWithQuery(this.query);
}