import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/auth/password/password_event.dart';
import 'package:my_app/bloc/auth/password/password_state.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/repository/auth/auth_api_repository.dart';

class ChangePasswordBloc extends Bloc<PasswordEvent, ChangePasswordState> {
  final AuthApiRepository authHttpRepository;
  ChangePasswordBloc({required this.authHttpRepository})
      : super(const ChangePasswordState(postApiStatus: PostApiStatus.initial)) {
    on<ChangePassword>(_changePassword);
  }

  _changePassword(
      ChangePassword event, Emitter<ChangePasswordState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading, message: ""));
    final body = {
      "currentPassword": event.currentPassword,
      "newPassword": event.confirmPassword
    };
    await authHttpRepository.updatePassword(body).then((value) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.success,
          message: "Password Has Been Changed"));
    }).onError((error, _) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.error, message: error.toString()));
    });
  }
}
