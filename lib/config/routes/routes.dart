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
import 'package:my_app/view/chat/chat_screen.dart';
import 'package:my_app/view/entry_point_screen.dart';
import 'package:my_app/view/home/all_product_screen.dart';
import 'package:my_app/view/home/details_screen.dart';
import 'package:my_app/view/home/home_screen.dart';
import 'package:my_app/view/home/order_screen.dart';
import 'package:my_app/view/home/search_screen.dart';
import 'package:my_app/view/home/submit_order_screen.dart';
import 'package:my_app/view/order/tracking_order.dart';
import 'package:my_app/view/profile/profile_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouteName.splashScreenName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.entryScreenName:
        return MaterialPageRoute(builder: (_) => const EntryPointScreen());
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
      case RouteName.homeScreenName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteName.detailScreenName:
        final data = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => DetailsScreen(
                  data: data["data"],
                ));
      case RouteName.orderScreenName:
        return MaterialPageRoute(builder: (_) => const OrderScreen());
      case RouteName.submitScreenName:
        return MaterialPageRoute(builder: (_) => const SubmitOrderScreen());
      case RouteName.profileScreenName:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RouteName.chatScreenName:
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case RouteName.trackingOrderScreenName:
        return MaterialPageRoute(builder: (_) => const TrackingOrder());
      case RouteName.allProductScreenName:
        return MaterialPageRoute(builder: (_) => const AllProductScreen());
      case RouteName.searchScreenName:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
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
