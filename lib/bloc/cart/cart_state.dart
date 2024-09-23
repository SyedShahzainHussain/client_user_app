part of 'cart_bloc.dart';

// ignore: must_be_immutable
class CartItemState extends Equatable {
  final int noOfCartItem;
  final double totalCartPrice;
  int productQuantityInCart;
  final List<CartItem> cartItem;

  final List<Toppings> selectedToppings;
  final List<Toppings> getselectedToppingsAccordingToThereCategory;

  CartItemState({
    this.noOfCartItem = 1,
    this.productQuantityInCart = 0,
    this.totalCartPrice = 0,
    this.cartItem = const [],
    this.selectedToppings = const [],
    this.getselectedToppingsAccordingToThereCategory = const [],
  });

  CartItemState copyWith(
      {int? noOfCartItem,
      double? totalCartPrice,
      int? productQuantityInCart,
      List<CartItem>? cartItem,
      List<Toppings>? selectedToppings,
      List<Toppings>? getselectedToppingsAccordingToThereCategory}) {
    return CartItemState(
      noOfCartItem: noOfCartItem ?? this.noOfCartItem,
      productQuantityInCart:
          productQuantityInCart ?? this.productQuantityInCart,
      totalCartPrice: totalCartPrice ?? this.totalCartPrice,
      cartItem: cartItem ?? this.cartItem,
      selectedToppings: selectedToppings ?? this.selectedToppings,
      getselectedToppingsAccordingToThereCategory:
          getselectedToppingsAccordingToThereCategory ??
              this.getselectedToppingsAccordingToThereCategory,
    );
  }

  @override
  List<Object?> get props => [
        noOfCartItem,
        productQuantityInCart,
        totalCartPrice,
        cartItem,
        selectedToppings,
        getselectedToppingsAccordingToThereCategory,
      ];
}
