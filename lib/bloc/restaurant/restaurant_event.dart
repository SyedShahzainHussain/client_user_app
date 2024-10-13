import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchRestaurant extends RestaurantEvent {
  FetchRestaurant();
}
