part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final XFile? image;
  final String title;
  final String address;
  final PostApiStatus postApiStatus;
  final String message;
  final String name, email, profilePic;

  const ProfileState({
    this.title = "",
    this.address = "",
    this.image,
    this.postApiStatus = PostApiStatus.initial,
    this.message = "",
    this.name = "",
    this.email = "",
    this.profilePic = "",
  });

  ProfileState copyWith({
    XFile? image,
    String? title,
    String? address,
    String? message,
    PostApiStatus? postApiStatus,
    String? name,
    String? email,
    String? profilePic,
  }) {
    return ProfileState(
      address: address ?? this.address,
      image: image ?? this.image,
      title: title ?? this.title,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  @override
  List<Object?> get props => [
        title,
        address,
        image,
        message,
        name,
        email,
        profilePic,
      ];
}
