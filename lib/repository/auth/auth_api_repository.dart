import 'dart:io';

import 'package:my_app/model/user_model.dart';

abstract class AuthApiRepository {
  // Todo Sign Up Method
  Future<dynamic> signUp(dynamic body);
  // Todo Sign In Method
  Future<UserModel> signIn(dynamic body);
  // Todo Forgot Password
  Future<dynamic> forgotPassword(dynamic body);
  // Todo Reset Password
  Future<dynamic> resetPassword(dynamic body);
  // Todo Google
  Future<UserModel> signInWithGoogle(dynamic body);
    // Todo Facebook
  Future<UserModel> signInWithFacebook(dynamic body);

  // Todo Update Profile
  Future<dynamic> updateUser(File? image, Map<String, dynamic> additionalData);

  // Todo Update Password
  Future<void> updatePassword(dynamic body);


}
 