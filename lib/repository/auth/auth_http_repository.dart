import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/config/url.dart';
import 'package:my_app/data/network/base_api_services.dart';
import 'package:my_app/data/network/network_api_services.dart';
import 'package:my_app/model/user_model.dart' as user;
import 'package:my_app/repository/auth/auth_repository.dart';

class AuthHttpRepository extends AuthApiRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future signUp(body) async {
    try {
      print(Urls.registerUrl);
      print(Urls.baseUrl);
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
}
