part of 'social_bloc_bloc.dart';

class SocialBlocState extends Equatable {
  final String displayName;
  final String profilePic;
  final String email;
  final String message;
  final String phoneNumber;
  final PostApiStatus postApiStatus;
  const SocialBlocState(
      {this.displayName = "",
      this.profilePic = "",
      this.email = "",
      this.phoneNumber = "",
      this.message= "",
      this.postApiStatus = PostApiStatus.initial});

  SocialBlocState copyWith(
      {String? displayName,
      String? profilePic,
      String? email,
      String? phoneNumber,
      String? message,
      PostApiStatus? postApiStatus}) {
    return SocialBlocState(
      displayName: displayName ?? this.displayName,
      profilePic: profilePic ?? this.profilePic,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      message:message??this.message,
    );
  }

  @override
  List<Object> get props =>
      [profilePic, email, displayName, phoneNumber, postApiStatus,message];
}
