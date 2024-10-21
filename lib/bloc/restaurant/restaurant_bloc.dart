import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/data/response/response.dart';
import 'package:my_app/bloc/restaurant/rastaurant_state.dart';
import 'package:my_app/bloc/restaurant/restaurant_event.dart';
import 'package:my_app/repository/restaurant/restaurant_http_repository.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantHttpRepository restaurantRepository;
  RestaurantBloc({required this.restaurantRepository})
      : super(RestaurantState(
          restaurantList: ApiResponse.initial(),
          restaurantCategoryList: ApiResponse.initial(),
          restaurantDetailsList: ApiResponse.initial()
        )) {
    on<FetchRestaurant>(_fetchRestaurant);
    on<RestaurantCategoryApi>(_restaurantCategoryApi);
    on<RestaurantDetails>(_restaurantDetails);
  }

  _fetchRestaurant(FetchRestaurant event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(restaurantList: ApiResponse.loading()));
    await restaurantRepository.getAllRestaurant().then((data) {
      emit(state.copyWith(restaurantList: ApiResponse.complete(data)));
    }).onError((error, _) {
      emit(state.copyWith(restaurantList: ApiResponse.error(error.toString())));
    });
  }

  _restaurantCategoryApi(
      RestaurantCategoryApi event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(restaurantCategoryList: ApiResponse.loading()));
    await restaurantRepository.getAllRestaurantCategory().then((data) {
      emit(state.copyWith(restaurantCategoryList: ApiResponse.complete(data)));
    }).onError((error, _) {
      emit(state.copyWith(
          restaurantCategoryList: ApiResponse.error(error.toString())));
    });
  }

  _restaurantDetails(
      RestaurantDetails event, Emitter<RestaurantState> emit) async {
        emit(state.copyWith(restaurantDetailsList: ApiResponse.loading()));
    await restaurantRepository.getRestaurantDetails(event.id).then((data) {
      emit(state.copyWith(restaurantDetailsList: ApiResponse.complete(data)));
    }).onError((error, _) {
      emit(state.copyWith(
          restaurantDetailsList: ApiResponse.error(error.toString())));
    });
      }
}
