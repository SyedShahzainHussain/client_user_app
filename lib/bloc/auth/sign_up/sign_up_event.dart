part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class EmailChange extends SignUpEvent {
  final String email;
  const EmailChange(this.email);
}

class PasswordChange extends SignUpEvent {
  final String password;
  const PasswordChange(this.password);
}

class PhoneNumberChange extends SignUpEvent {
  final String phoneNumber;
  const PhoneNumberChange(this.phoneNumber);
}

class NameChange extends SignUpEvent {
  final String name;
  const NameChange(this.name);
}

class PasswordVisibleOrNot extends SignUpEvent {
  const PasswordVisibleOrNot();
}

class CheckBoxVisibleOrNot extends SignUpEvent {
  const CheckBoxVisibleOrNot();
}

class SignUpButton extends SignUpEvent {
  const SignUpButton();
}
