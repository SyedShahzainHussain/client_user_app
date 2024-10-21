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
  static String categoryUrl = "category";
  static String productUrl = "product";
  static String brandUrl = "brand";
  static String wishlistUrl = "wishlist";
  static String updateUserUrl = "update-user";
  static String toppingUrl = "topping";
  static String sideToppingUrl = "sidetopping";
  static String placeOrder = "order";
  static String getOrder = "order";
  static String addToCartUrl = "cart";
  static String deleteCartUrls = "emptycart";
  static String googleUrls = "auth/google/callback";
  static String facebookUrls = "auth/facebook/callback";
  static String cashOnDelivery = "order";
  static String stripePayment = "payment";
  static String resturant = "resturant";
  static String resturantCategory = "resturant-category";
  static String address = "address";
  static String changePassword = "change-password";
  static String createRating = "create";
}
