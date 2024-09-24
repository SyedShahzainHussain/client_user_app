import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/model/user_model.dart' as user;

abstract class AuthApiRepository {
  // Todo Sign Up Method
  Future<dynamic> signUp(dynamic body);
  // Todo Sign In Method
  Future<user.UserModel> signIn(dynamic body);
  // Todo Forgot Password
  Future<dynamic> forgotPassword(dynamic body);
  // Todo Reset Password
  Future<dynamic> resetPassword(dynamic body);
  // Todo Google
  Future<User> signInWithGoogle();

  // Todo Update Profile
  Future<dynamic> updateUser(File? image, Map<String, dynamic> additionalData);


}
 