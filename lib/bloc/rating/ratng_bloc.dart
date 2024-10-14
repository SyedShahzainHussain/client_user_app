import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/rating/rating_event.dart';
import 'package:my_app/bloc/rating/rating_state.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/repository/rating/rating_api_repository.dart';
import 'package:my_app/services/session_controller_services.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final RatingApiRepository ratingApiRepository;
  RatingBloc({required this.ratingApiRepository})
      : super(const RatingState(postApiStatus: PostApiStatus.initial)) {
    on<CreateRating>(_createRating);
  }

  _createRating(CreateRating event, Emitter<RatingState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading, message: ""));
    final body = {
      "message": "Great product!",
      "ratings": [
        {
          "star": 5,
          "comment": "Excellent service!",
          "postedby": SessionController().userModel.user!.id
        }
      ]
    };
    await ratingApiRepository.createRating(body).then((value) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.success,
          message: "Rating Has Been Send"));
    }).onError((error, _) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.error, message: error.toString()));
    });
  }
}
