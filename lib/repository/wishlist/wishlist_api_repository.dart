import './wishlist_repository.dart';
abstract class WishListApiRepository {
  Future updateWishList(dynamic body );
  Future<List<Data>> getWishList( );
}
