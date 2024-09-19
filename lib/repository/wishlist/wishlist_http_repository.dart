import 'wishlist_repository.dart';

class WishlistHttpRepository extends WishListApiRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();
  @override
  Future updateWishList(dynamic body) async {
    try {
      await baseApiServices.getPutApiResponse(Urls.wishlistUrl, body);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<Data>> getWishList() async {
    try {
      final response =
          await baseApiServices.getGetApiResponse(Urls.wishlistUrl);
      if (response["message"] == "Wishlist is empty") {
        return [];
      }
      final data = response['wishlist'] as List;
      return data.map((e) {
        return Data.fromJson(e);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
