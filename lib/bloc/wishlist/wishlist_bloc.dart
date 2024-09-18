import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/model/product_model.dart';
import 'package:equatable/equatable.dart';

part 'wishlist_state.dart';
part 'wishlit_event.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(const WishlistState()) {
    on<AddWishlist>(_addWishlist);
  }

  _addWishlist(AddWishlist event, Emitter<WishlistState> emit) {
    final updatedProductList = List<Data>.from(state.wishlistProduct);

    if (!updatedProductList.contains(event.productModel)) {
      updatedProductList.add(event.productModel);
    } else {
      updatedProductList.remove(event.productModel);
    }

    emit(state.copyWith(wishlistProduct: updatedProductList));
  }
}
