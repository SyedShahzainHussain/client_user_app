import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/repository/auth/auth_api_repository.dart';
import 'package:my_app/services/session_controller_services.dart';
import 'package:my_app/utils/utils.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthApiRepository apiRepository;
  ProfileBloc({required this.apiRepository}) : super(const ProfileState()) {
    on<PickImageEvent>(_pickImageEvent);
    on<ClearPickImageEvent>(_clearPickImageEvent);
    on<UpdateProfile>(_updateProfile);
    on<GetProfileData>(_getProfileData);
  }

  _pickImageEvent(PickImageEvent event, Emitter<ProfileState> emit) async {
    final image = await Utils().showBottomSheetDialog(event.context);
    if (image != null) {
      emit(state.copyWith(image: image));
    }
  }

  _clearPickImageEvent(ClearPickImageEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(image: XFile("")));
  }

  _updateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading, message: ""));

    // Prepare additional data and image file
    final imageFile = state.image != null ? File(state.image!.path) : null;

    await apiRepository
        .updateUser(imageFile, event.additionalData)
        .then((value) async {
      final token = SessionController().userModel.token;
      await SessionController().saveUserPrefrence(UserModel(
          message: "",
          token: token.toString(),
          user: User.fromJson(value["user"])));
      await SessionController().getUserPrefrences().then((_) {
        if (event.context.mounted) {
          event.context.read<ProfileBloc>().add(GetProfileData());
        }
      });
      emit(state.copyWith(
          postApiStatus: PostApiStatus.success,
          message: "User Profile Updated"));
    }).onError((error, _) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.error, message: error.toString()));
    });
  }

  _getProfileData(GetProfileData event, Emitter<ProfileState> emit) async {
    final address = SessionController().userModel.user?.address.toString()??"";
    final name = SessionController().userModel.user!.name.toString();
    final email = SessionController().userModel.user!.email.toString();
    final profileImage = SessionController().userModel.user!.image ??
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png";

    emit(state.copyWith(
        name: name, address: address, email: email, profilePic: profileImage));
  }
}
