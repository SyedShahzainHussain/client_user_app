import 'dart:io';

import 'package:my_app/model/user_model.dart';

import 'auth_repository.dart';

class AuthHttpRepository extends AuthApiRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future signUp(body) async {
    try {
      await baseApiServices.getPostApiResponse(Urls.registerUrl, body);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signIn(body) async {
    try {
      final response =
          await baseApiServices.getPostApiResponse(Urls.loginUrl, body);
      return UserModel.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> forgotPassword(body) async {
    try {
      final response = await baseApiServices.getPostApiResponse(
          Urls.forgotPasswordUrl, body);
      return response["code"];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future resetPassword(body) async {
    try {
      await baseApiServices.getPostApiResponse(Urls.resetPasswordUrl, body);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithGoogle(dynamic body) async {
    try {
      print("${Urls.baseUrl}${Urls.googleUrls}");
      final response =
          await baseApiServices.getPostEmptyBodyApiResponse(Urls.googleUrls);
      return UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithFacebook(dynamic body) async {
    try {
      final response =
          await baseApiServices.getPostEmptyBodyApiResponse(Urls.facebookUrls);
      return UserModel.fromJson(response);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future updateUser(File? image, Map<String, dynamic> additionalData) async {
    try {
      final response = await baseApiServices.putFormData(
          url: Urls.updateUserUrl,
          singleFile: true,
          image: image,
          additionalData: additionalData);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
