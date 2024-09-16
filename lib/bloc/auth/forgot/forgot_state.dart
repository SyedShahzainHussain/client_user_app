part of 'forgot_bloc.dart';

class ForgotState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String otp;
  final PostApiStatus postApiStatus;
  final String message;
  final bool passwordVisible;
  final bool confirmPasswordVisible;

  const ForgotState({
    this.email = "",
    this.password = "",
    this.confirmPassword = "",
    this.otp = "",
    this.postApiStatus = PostApiStatus.initial,
    this.message = "",
    this.passwordVisible = false,
    this.confirmPasswordVisible = false,
  });

  ForgotState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? otp,
    PostApiStatus? postApiStatus,
    String? message,
    bool? passwordVisible,
    bool? confirmPasswordVisible,
  }) {
    return ForgotState(
      email: email ?? this.email,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      message: message ?? this.message,
      otp: otp ?? this.otp,
      password: password ?? this.password,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        confirmPassword,
        otp,
        postApiStatus,
        message,
        passwordVisible,
        confirmPasswordVisible
      ];
}
