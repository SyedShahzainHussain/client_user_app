part of "wishlist_bloc.dart";

abstract class WishlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddWishlist extends WishlistEvent {
  final Data productModel;
  AddWishlist(this.productModel);
}

