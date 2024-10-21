import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/data/response/response.dart';
import 'package:my_app/bloc/restaurant/rastaurant_state.dart';
import 'package:my_app/bloc/restaurant/restaurant_event.dart';
import 'package:my_app/repository/restaurant/restaurant_http_repository.dart';
import 'package:my_app/repository/restaurant/restaurant_repository.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantHttpRepository restaurantRepository;
  RestaurantBloc({required this.restaurantRepository})
      : super(RestaurantState(restaurantList: ApiResponse.initial())) {
    on<FetchRestaurant>(_fetchRestaurant);
  }

  _fetchRestaurant(FetchRestaurant event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(restaurantList: ApiResponse.loading()));
    await restaurantRepository.getAllRestaurant().then((data) {
      emit(state.copyWith(restaurantList: ApiResponse.complete(data)));
    }).onError((error, _) {
      emit(state.copyWith(restaurantList: ApiResponse.error(error.toString())));
    });
  }
}
