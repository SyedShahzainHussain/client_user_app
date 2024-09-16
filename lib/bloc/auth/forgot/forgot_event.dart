part of 'forgot_bloc.dart';

abstract class ForgotEvent extends Equatable {
  const ForgotEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmail extends ForgotEvent {
  final String email;
  const ChangeEmail(this.email);
}

class ChangeOtpNumber extends ForgotEvent {
  final String otp;
  const ChangeOtpNumber(this.otp);
}

class ChangePassword extends ForgotEvent {
  final String password;
  const ChangePassword(this.password);
}

class ChangeConfirmPassword extends ForgotEvent {
  final String confirmPassword;
  const ChangeConfirmPassword(this.confirmPassword);
}

class PasswordIsVisible extends ForgotEvent {}

class ConfirmPasswordIsVisible extends ForgotEvent {}

class ForgotButton extends ForgotEvent {}

class OtpButton extends ForgotEvent {}

