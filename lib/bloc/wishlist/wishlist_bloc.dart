import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/data/response/response.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/repository/wishlist/wishlist_api_repository.dart';

part 'wishlist_state.dart';
part 'wishlit_event.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishListApiRepository wishListApiRepository;
  WishlistBloc({required this.wishListApiRepository})
      : super(WishlistState(
            postApiStatus: PostApiStatus.initial,
            backendWishListProducts: ApiResponse.loading())) {
    on<AddWishlist>(_addWishlist);
    on<GetWishlist>(_getWishlist);
  }
  _addWishlist(AddWishlist event, Emitter<WishlistState> emit) async {
    final updatedProductList = List<Data>.from(state.wishlistProduct);
    emit(state.copyWith(postApiStatus: PostApiStatus.initial));

    // Check if the product is already in the wishlist by comparing IDs
    final productExists = updatedProductList
        .any((product) => product.sId == event.productModel.sId);

    if (!productExists) {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading, message: ""));
      final body = {"prodId": event.productModel.sId};

      await wishListApiRepository.updateWishList(body).then((value) {
        updatedProductList.add(event.productModel);
        emit(state.copyWith(
          postApiStatus: PostApiStatus.success,
          message: "Product Added To WishList",
          wishlistProduct: updatedProductList,
        ));
      }).onError((error, _) {
        emit(state.copyWith(postApiStatus: PostApiStatus.error));
      });
    } else {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading, message: ""));
      final body = {"prodId": event.productModel.sId};

      await wishListApiRepository.updateWishList(body).then((value) {
        updatedProductList
            .removeWhere((product) => product.sId == event.productModel.sId);
        emit(state.copyWith(
          postApiStatus: PostApiStatus.success,
          message: "Product Removed From WishList",
          wishlistProduct: updatedProductList,
        ));
      }).onError((error, _) {
        emit(state.copyWith(postApiStatus: PostApiStatus.error));
      });
    }
  }

  _getWishlist(GetWishlist event, Emitter<WishlistState> emit) async {
    emit(state.copyWith(backendWishListProducts: ApiResponse.loading()));
    await wishListApiRepository.getWishList().then((value) {
      emit(state.copyWith(
        backendWishListProducts: ApiResponse.complete(value),
        wishlistProduct: List.from(value),
      ));
    }).onError((erro, _) {
      emit(state.copyWith(
          backendWishListProducts: ApiResponse.error(erro.toString()),
          wishlistProductNodel: []));
    });
  }
}
