part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class PickImageEvent extends ProfileEvent {
  final BuildContext context;
  const PickImageEvent(this.context);
}

class ClearPickImageEvent extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final Map<String, dynamic> additionalData;
  final BuildContext  context;
  const UpdateProfile(this.additionalData,this.context);
}

class GetProfileData extends ProfileEvent {}
