import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class ChangePassword extends PasswordEvent{
  final String currentPassword;
  final String confirmPassword;
  ChangePassword({required this.confirmPassword,required this.currentPassword});
}


