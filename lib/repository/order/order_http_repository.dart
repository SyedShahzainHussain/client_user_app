import 'package:my_app/config/url.dart';
import 'package:my_app/data/network/base_api_services.dart';
import 'package:my_app/data/network/network_api_services.dart';
import 'package:my_app/model/order_model.dart';
import 'package:my_app/repository/order/order_api_repository.dart';

class OrderHttpRepository extends OrderApiRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future<void> placeOrdersApi() async {
    try {
      await baseApiServices.getPostEmptyBodyApiResponse(Urls.placeOrder);
    } catch (e) {
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

  @override
  Future<void> checkOutOrder(body) async {
    try {
      final respose = await baseApiServices.getPostApiResponse(
        Urls.cashOnDelivery,
        body,
      );
      print("Data $respose");
    } catch (e) {
      print("Error $e");
      rethrow;
    }
  }

  @override
  Future<void> checkOutStripeOrder(body) async {
    try {
      await baseApiServices.getPostApiResponse(
        Urls.stripePayment,
        body,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
    final response =    await baseApiServices.getGetApiResponse(Urls.getOrder);
    final data = response as List;
    return data.map((e)=>OrderModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
