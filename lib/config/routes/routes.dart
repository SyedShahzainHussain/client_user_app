import 'package:flutter/material.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/view/auth/forgot_password/forgot_password_screen.dart';
import 'package:my_app/view/auth/login/login_screen.dart';
import 'package:my_app/view/auth/on_board/on_board_screen.dart';
import 'package:my_app/view/auth/otp/otp_screen.dart';
import 'package:my_app/view/auth/reset_password/reset_password_screen.dart';
import 'package:my_app/view/auth/signup/signup_screen.dart';
import 'package:my_app/view/auth/splash/splash_screen.dart';
import 'package:my_app/view/auth/succes_screen/success_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouteName.splashScreenName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.onBoardScreenName:
        return MaterialPageRoute(builder: (_) => const OnBoardScreen());
      case RouteName.signUpScreenName:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case RouteName.loginScreenName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.forgotScreenName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case RouteName.otpScreenName:
        return MaterialPageRoute(builder: (_) => const OtpScreen());
      case RouteName.resetScreenName:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case RouteName.successScreenName:
        return MaterialPageRoute(builder: (_) => const SuccessScreen());

      default:
        return MaterialPageRoute(builder: (ctx) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
