import 'package:equatable/equatable.dart';
import 'package:my_app/enums/enums.dart';

class RatingState extends Equatable {
  final PostApiStatus postApiStatus;
  final String message;

  const RatingState({required this.postApiStatus, this.message = ""});

  RatingState copyWith({PostApiStatus? postApiStatus, String? message}) {
    return RatingState(
        postApiStatus: postApiStatus ?? this.postApiStatus,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [postApiStatus, message];
}
