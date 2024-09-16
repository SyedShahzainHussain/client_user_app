part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final String email;
  final String name;
  final String password;
  final String phoneNumber;
  final bool isObsecure;
  final bool isCheckBox;
  final String message;
  final PostApiStatus postApiStatus;

  const SignUpState({
    this.email = '',
    this.isObsecure = true,
    this.isCheckBox = false,
    this.password = '',
    this.phoneNumber = '',
    this.message = '',
    this.name = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  SignUpState copyWith({
    String? email,
    String? name,
    String? password,
    String? phoneNumber,
    bool? isObsecure,
    String? message,
    PostApiStatus? postApiStatus,
    bool? isCheckBox,
  }) {
    return SignUpState(
      email: email ?? this.email,
      isObsecure: isObsecure ?? this.isObsecure,
      message: message ?? this.message,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      isCheckBox: isCheckBox ?? this.isCheckBox,
      name: name??this.name,
    );
  }

  @override
  List<Object> get props => [
        email,
        isObsecure,
        password,
        phoneNumber,
        message,
        postApiStatus,
        isCheckBox,
        name,
      ];
}
