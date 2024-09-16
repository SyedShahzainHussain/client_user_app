import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/repository/auth/auth_api_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthApiRepository loginRepository;
  SignUpBloc({required this.loginRepository}) : super(const SignUpState()) {
    on<EmailChange>(_emailChanged);
    on<PasswordChange>(_passwordChanged);
    on<PasswordVisibleOrNot>(_isPasswordVisibleOrNot);
    on<CheckBoxVisibleOrNot>(_checkBoxVisibleOrNot);
    on<PhoneNumberChange>(_phoneNumberChange);
    on<NameChange>(_nameChanged);
    on<SignUpButton>(_signUpButton);

  }

  _emailChanged(EmailChange event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(email: event.email));
  }

  _passwordChanged(PasswordChange event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  _checkBoxVisibleOrNot(
      CheckBoxVisibleOrNot event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(isCheckBox: !state.isCheckBox));
  }

  _nameChanged(NameChange event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(name: event.name));
  }

  _isPasswordVisibleOrNot(
      PasswordVisibleOrNot event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(isObsecure: !state.isObsecure));
  }

  _phoneNumberChange(PhoneNumberChange event,Emitter<SignUpState> emit)async{
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  _signUpButton(SignUpButton event, Emitter<SignUpState> emit) async {
    final body = {
      "email": state.email,
      "password": state.password,
      "number": state.phoneNumber,
      "name": state.name,
    };
    emit(state.copyWith(postApiStatus: PostApiStatus.loading, message: ""));
    await loginRepository.signUp(jsonEncode(body)).then((value) async {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.success,
          message: "Register Successfully"));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.error, message: error.toString()));
    });
  }
}
  