part of 'wishlist_bloc.dart';

class WishlistState extends Equatable {
  final PostApiStatus postApiStatus;
  final List<Data> wishlistProduct;
  final ApiResponse<List<Data>> backendWishListProducts;
  final String message;

  const WishlistState(
      {this.wishlistProduct = const [],
      required this.postApiStatus,
      required this.backendWishListProducts,
      this.message="",
      });

  WishlistState copyWith(
      {List<Data>? wishlistProduct,
      PostApiStatus? postApiStatus,
ApiResponse<List<Data>>? backendWishListProducts,
      List<Data>? wishlistProductNodel,String? message}) {
    return WishlistState(
      wishlistProduct: wishlistProduct ?? this.wishlistProduct,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      backendWishListProducts:
          backendWishListProducts ?? this.backendWishListProducts,
          message: message??this.message,
    );
  }

  @override
  List<Object?> get props => [
        wishlistProduct,
        postApiStatus,
        backendWishListProducts,
        message,
      ];
}
