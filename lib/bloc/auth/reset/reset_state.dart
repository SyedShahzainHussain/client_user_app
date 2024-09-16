import 'package:equatable/equatable.dart';
import 'package:my_app/enums/enums.dart';

class ResetState extends Equatable {
  final PostApiStatus postApiStatus;
  final String message;

  const ResetState(
      {this.postApiStatus = PostApiStatus.initial, this.message = ""});

  ResetState copyWith({PostApiStatus? postApiStatus, String? message}) {
    return ResetState(
        message: message ?? this.message,
        postApiStatus: postApiStatus ?? this.postApiStatus);
  }

  @override
  List<Object?> get props => [postApiStatus, message];
}
