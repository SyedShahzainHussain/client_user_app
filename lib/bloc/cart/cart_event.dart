part of 'cart_bloc.dart';

sealed class CartItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTopping extends CartItemEvent {
  final BuildContext context;
  final Toppings toppingModel;
  AddTopping({required this.toppingModel, required this.context});
}

class ClearToppins extends CartItemEvent {
  final String category;
  ClearToppins({required this.category});
}

class GetAllToppingsAccordingToTheirCategory extends CartItemEvent {
  final String category;
  GetAllToppingsAccordingToTheirCategory({required this.category});
}

class IncrementCount extends CartItemEvent {
  IncrementCount();
}

class DecrementCount extends CartItemEvent {
  DecrementCount();
}

class GetSpecificProductQuantity extends CartItemEvent {
  final String productId;
  GetSpecificProductQuantity({required this.productId});
}

class AddToCart extends CartItemEvent {
  final CartItem cartItem;
  final BuildContext context;
  AddToCart(this.cartItem, this.context);
}

class AddOneToCart extends CartItemEvent {
  final CartItem cartItem;
  final BuildContext context;
  AddOneToCart(this.cartItem, this.context);
}

class RemoveFromCart extends CartItemEvent {
  final String productId;
  final BuildContext context;
  RemoveFromCart(this.productId, this.context);
}

class UpdateCartTotal extends CartItemEvent {
  UpdateCartTotal();
}

class DeleteSpecificCart extends CartItemEvent {
  final String productId;
  final BuildContext context;
  DeleteSpecificCart(this.productId, this.context);
}

class LoadCartItem extends CartItemEvent {
  final BuildContext context;
  LoadCartItem(this.context);
}


class ClearCartList extends CartItemEvent{
  ClearCartList();
}