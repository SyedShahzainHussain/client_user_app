import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/bloc/restaurant/rastaurant_state.dart';
import 'package:my_app/bloc/restaurant/restaurant_event.dart';
import 'package:my_app/repository/restaurant/restaurant_repository.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository restaurantRepository;
  RestaurantBloc({required this.restaurantRepository})
      : super(const RestaurantState(postApiStatus: PostApiStatus.initial)) {
    on<FetchRestaurant>(_fetchRestaurant);
  }

  _fetchRestaurant(FetchRestaurant event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    await restaurantRepository.getAllRestaurant().then((data) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.success, restaurantList: data));
    }).onError((error, _) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    });
  }
}
