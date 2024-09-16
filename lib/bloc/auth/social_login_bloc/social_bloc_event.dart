part of 'social_bloc_bloc.dart';

abstract  class SocialBlocEvent extends Equatable {
  const SocialBlocEvent();

  @override
  List<Object> get props => [];
}


class GoogleSignInEvent extends SocialBlocEvent{}

class FacebookSignInEvent extends SocialBlocEvent{}