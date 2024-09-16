import 'package:my_app/environment/environment.dart';

class Urls {
  static get https => 'https://';
  static get http => 'http://';
  static final bool isHttp = Environment().baseConfig!.useHttps;
  static var baseUrl = isHttp
      ? '$https${Environment().baseConfig!.apiHost}'
      : '$http${Environment().baseConfig!.apiHost}';

  static String loginUrl = "login";
  static String registerUrl = "register";
  static String forgotPasswordUrl = "forgot-password";
  static String resetPasswordUrl = "reset-password";
}
