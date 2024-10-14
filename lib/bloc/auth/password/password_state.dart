import 'package:equatable/equatable.dart';
import 'package:my_app/enums/enums.dart';

class ChangePasswordState extends Equatable {
  final PostApiStatus postApiStatus;
  final String message;

  const ChangePasswordState({required this.postApiStatus,this.message=""});

  ChangePasswordState copyWith({PostApiStatus? postApiStatus,String? message}) {
    return ChangePasswordState(
        postApiStatus: postApiStatus ?? this.postApiStatus,message: message??this.message);
  }

  @override
  List<Object?> get props => [postApiStatus,message];
}
