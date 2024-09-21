import 'dart:io';

import 'package:my_app/model/user_model.dart' as user;

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
  Future<user.UserModel> signIn(body) async {
    try {
      final response =
          await baseApiServices.getPostApiResponse(Urls.loginUrl, body);
      return user.UserModel.fromJson(response);
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
  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credentials);
      User user = userCredential.user!;
      return user;
    } catch (e) {
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
