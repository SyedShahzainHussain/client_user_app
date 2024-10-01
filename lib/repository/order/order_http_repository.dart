import 'package:my_app/config/url.dart';
import 'package:my_app/data/network/base_api_services.dart';
import 'package:my_app/data/network/network_api_services.dart';
import 'package:my_app/repository/order/order_api_repository.dart';

class OrderHttpRepository extends OrderApiRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future<void> placeOrdersApi() async {
    try {
      await baseApiServices.getPostEmptyBodyApiResponse(Urls.placeOrder);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> addToCart(dynamic body) async {
    try {
      await baseApiServices.getPostApiResponse(Urls.addToCartUrl, body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future clearCart(dynamic body) async {
    try {
      await baseApiServices.deletePostApiResponse(
        Urls.deleteCartUrls,
        body,
      );
    } catch (e) {
      rethrow;
    }
  }
}
