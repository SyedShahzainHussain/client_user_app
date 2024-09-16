import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/repository/auth/auth_api_repository.dart';

part 'forgot_event.dart';
part 'forgot_state.dart';

class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {
  AuthApiRepository authApiRepository;
  String otpCodeFromBackend = "";
  ForgotBloc({required this.authApiRepository}) : super(const ForgotState()) {
    on<ChangeEmail>(_changeEmail);
    on<ChangeOtpNumber>(_changeOtpNumber);
    on<ChangePassword>(_changePassword);
    on<ChangeConfirmPassword>(_changeConfirmPassword);
    on<ForgotButton>(_forgotButton);
    on<PasswordIsVisible>(_passwordIsVisible);
    on<ConfirmPasswordIsVisible>(_changeConfirmPasswordVisible);
    on<OtpButton>(_otpButton);
  }

  _changeEmail(ChangeEmail event, Emitter<ForgotState> emit) {
    emit(state.copyWith(email: event.email));
  }

  _changeOtpNumber(ChangeOtpNumber event, Emitter<ForgotState> emit) {
    emit(state.copyWith(otp: event.otp));
  }

  _changePassword(ChangePassword event, Emitter<ForgotState> emit) {
    emit(state.copyWith(password: event.password));
  }

  _changeConfirmPassword(
      ChangeConfirmPassword event, Emitter<ForgotState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  _changeConfirmPasswordVisible(
      ConfirmPasswordIsVisible event, Emitter<ForgotState> emit) {
    emit(state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible));
  }

  _forgotButton(ForgotButton event, Emitter<ForgotState> emit) async {
    final body = {"email": state.email};
    emit(state.copyWith(postApiStatus: PostApiStatus.loading, message: ""));
    await authApiRepository.forgotPassword(jsonEncode(body)).then((value) {
      if (kDebugMode) {
        print(value);
      }

      otpCodeFromBackend = value.toString();
      print(otpCodeFromBackend);
      emit(state.copyWith(
          postApiStatus: PostApiStatus.success,
          message: "Otp Has Been Send To Your Email"));
    }).onError((error, _) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.error, message: error.toString()));
    });
  }

  _passwordIsVisible(PasswordIsVisible event, Emitter<ForgotState> emit) async {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  _otpButton(OtpButton event, Emitter<ForgotState> emit) async {
    emit(state.copyWith(message: ""));
    if (state.otp.toString() == otpCodeFromBackend) {
      emit(state.copyWith(message: "otp correct"));
    } else {
      emit(state.copyWith(message: "Invalid Code"));
    }
  }


}
