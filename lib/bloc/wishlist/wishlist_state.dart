

part of 'wishlist_bloc.dart';

class WishlistState extends Equatable {
  final List<Data> wishlistProduct;

  const WishlistState({this.wishlistProduct = const []});

  WishlistState copyWith({List<Data>? wishlistProduct}) {
    return WishlistState(
        wishlistProduct: wishlistProduct ?? this.wishlistProduct);
  }

  @override
  List<Object?> get props => [wishlistProduct];
}
