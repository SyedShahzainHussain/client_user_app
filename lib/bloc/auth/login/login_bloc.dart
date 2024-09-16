import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/repository/auth/auth_repository.dart';
import 'package:my_app/services/session_controller_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthApiRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(const LoginState()) {
    on<EmailChange>(_emailChanged);
    on<PasswordChange>(_passwordChanged);
    on<PasswordVisibleOrNot>(_isPasswordVisibleOrNot);
    on<LoginButton>(_loginButton);
  }
  _emailChanged(EmailChange event, Emitter<LoginState> emit) async {
    emit(state.copyWith(email: event.email));
  }

  _passwordChanged(PasswordChange event, Emitter<LoginState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  _isPasswordVisibleOrNot(
      PasswordVisibleOrNot event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isObsecure: !state.isObsecure));
  }

  _loginButton(LoginButton event, Emitter<LoginState> emit) async {
    final body = {"email": state.email, "password": state.password};

    emit(state.copyWith(postApiStatus: PostApiStatus.loading, message: ""));
    await loginRepository.signIn(jsonEncode(body)).then((value) async {
      await SessionController().saveUserPrefrence(value);
      await SessionController().getUserPrefrences();
      emit(state.copyWith(
          postApiStatus: PostApiStatus.success, message: "Login Successfully"));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.error, message: error.toString()));
    });
  }
}
