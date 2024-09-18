import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/repository/auth/auth_api_repository.dart';
import 'package:my_app/services/storage/local_storage.dart';

part 'social_bloc_event.dart';
part 'social_bloc_state.dart';

class SocialBlocBloc extends Bloc<SocialBlocEvent, SocialBlocState> {
  final AuthApiRepository authApiRepository;
  SocialBlocBloc({required this.authApiRepository})
      : super(const SocialBlocState()) {
    on<GoogleSignInEvent>(_googleSignInEvent);
    on<FacebookSignInEvent>(_facebookSignInEvent);
  }

  _googleSignInEvent(
      GoogleSignInEvent event, Emitter<SocialBlocState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));


    await authApiRepository.signInWithGoogle().then((user) async {
      
    await LocalStorage().setValue("name", user.displayName??"");
    await LocalStorage().setValue("email", user.email??"");
    await LocalStorage().setValue("profilePic", user.photoURL??"");
    await LocalStorage().setValue("phoneNumber", user.phoneNumber??"");
    await LocalStorage().setValue("provider", "google");
      emit(state.copyWith(
          displayName: user.displayName,
          email: user.email,
          profilePic: user.photoURL,
          phoneNumber: user.phoneNumber,
          postApiStatus: PostApiStatus.success,
          message: "Google Successfully Login"));
    }).onError((error, _) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.error, message: error.toString()));
    });
  }

  _facebookSignInEvent(
      FacebookSignInEvent event, Emitter<SocialBlocState> emit) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.initial));
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(
              "${loginResult.accessToken?.tokenString}");

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      final User user = userCredential.user!;

      if (kDebugMode) {
        print(
            "{displayName:${user.displayName},email:${user.email},profilePic:${user.photoURL},phoneNumber:${user.phoneNumber}}");
      }

      emit(state.copyWith(
        displayName: user.displayName,
        email: user.email,
        profilePic: user.photoURL,
        phoneNumber: user.phoneNumber,
        postApiStatus: PostApiStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    } finally {
      emit(state.copyWith(postApiStatus: PostApiStatus.initial));
    }
  }
}
