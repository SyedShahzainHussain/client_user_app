import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/model/cart_item_model.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/services/session_controller_services.dart';
import 'package:my_app/utils/utils.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartItemEvent, CartItemState> {
  CartBloc() : super(CartItemState()) {
    on<AddTopping>(_addTopping);
    on<ClearToppins>(_clearToppins);
    on<GetAllToppingsAccordingToTheirCategory>(
        _getAllToppingsAccordingToTheirCategory);

    on<IncrementCount>(_incrementCount);
    on<DecrementCount>(_decrementCount);
    on<GetSpecificProductQuantity>(_getSpecificProductQuantity);
    on<AddToCart>(_addToCart);
    on<AddOneToCart>(_addOneToCart);
    on<RemoveFromCart>(_removeFromCart);
    on<UpdateCartTotal>(_updateCartTotal);
    on<DeleteSpecificCart>(_deleteSpecificCart);
    on<LoadCartItem>(_loadCartItem);
  }

  // Todo Add Topppings
  _addTopping(AddTopping event, Emitter<CartItemState> emit) async {
    final toppings = List<Toppings>.from(state.selectedToppings);
    final toppingExists =
        toppings.any((topping) => topping.sId == event.toppingModel.sId);

    if (toppingExists) {
      toppings.removeWhere((topping) => topping.sId == event.toppingModel.sId);
    } else {
      toppings.add(event.toppingModel);
    }

    // After updating the toppings, get the current category's toppings

    // Emit the new state with the updated toppings
    emit(state.copyWith(selectedToppings: toppings));
  }

  // Todo Clear Topppings
  _clearToppins(ClearToppins event, Emitter<CartItemState> emit) async {
    final toppings = List<Toppings>.from(state.selectedToppings);
    toppings.removeWhere((data) => data.category == event.category);
    emit(state.copyWith(selectedToppings: toppings));
  }

  // Todo Get All Topppings
  _getAllToppingsAccordingToTheirCategory(
      GetAllToppingsAccordingToTheirCategory event,
      Emitter<CartItemState> emit) async {
    emit(state.copyWith(getselectedToppingsAccordingToThereCategory: []));
    final filteredToppings = state.selectedToppings
        .where((topping) => topping.category == event.category)
        .toList();
    emit(state.copyWith(
        getselectedToppingsAccordingToThereCategory: filteredToppings));
  }

  // Todo IncreaseCount Topppings
  _incrementCount(IncrementCount event, Emitter<CartItemState> emit) async {
    final newCount = state.noOfCartItem + 1;
    emit(state.copyWith(noOfCartItem: newCount));
  }

  // Todo DecreaseCount Topppings
  _decrementCount(DecrementCount event, Emitter<CartItemState> emit) async {
    if (state.noOfCartItem <= 1) {
      return;
    }
    final newCount = state.noOfCartItem - 1;
    emit(state.copyWith(noOfCartItem: newCount));
  }

  // Todo GetSpecificProductQuantity
  _getSpecificProductQuantity(
      GetSpecificProductQuantity event, Emitter<CartItemState> emit) async {
    final cartList = List<CartItem>.from(state.cartItem);
    var newCount = cartList.where((item) => item.sId == event.productId).fold(
        0, (previousValue, newValue) => previousValue + newValue.quantity);
    if (newCount == 0) {
      newCount = 1;
    }

    emit(state.copyWith(noOfCartItem: newCount));
  }

  // Todo Add To Cart
  _addToCart(AddToCart event, Emitter<CartItemState> emit) async {
    final cartList = List<CartItem>.from(state.cartItem);
    int index =
        cartList.indexWhere((cartItem) => cartItem.sId == event.cartItem.sId);

    if (index >= 0) {
      if (cartList[index].quantity == event.cartItem.quantity) {
        Utils.showToast(
            "This Product Quantity is already in the cart. \nPlease increase quantity");
      } else {
        cartList[index].quantity += 1;
        Utils.showToast("Product quantity increased!");
      }
    } else {
      cartList.add(event.cartItem);
      Utils.showToast("Product Added To Cart!");
    }
    emit(state.copyWith(cartItem: cartList));
    event.context.read<CartBloc>().add(UpdateCartTotal());
    saveCartItem(state.cartItem);
  }

  _addOneToCart(AddOneToCart event, Emitter<CartItemState> emit) async {
    final cartList = List<CartItem>.from(state.cartItem);
    int index =
        cartList.indexWhere((cartItem) => cartItem.sId == event.cartItem.sId);

    if (index >= 0) {
      cartList[index].quantity += 1;
    }
    emit(state.copyWith(cartItem: cartList));

    event.context.read<CartBloc>().add(UpdateCartTotal());
    saveCartItem(state.cartItem);
  }

  _removeFromCart(RemoveFromCart event, Emitter<CartItemState> emit) async {
    final cartList = List<CartItem>.from(state.cartItem);
    int index = cartList.indexWhere((item) => item.sId == event.productId);

    if (index >= 0) {
      if (state.cartItem[index].quantity > 1) {
        // Decrease the quantity of the item
        cartList[index].quantity -= 1;
        // Utils.showToaster(
        //     context: context, message: "Product quantity decreased!");
      } else {
        bool? confirmRemove =
            await removeFromCartDialog(index, emit, cartList, event.context);
        // Remove the item from the cart if quantity is 1
        if (confirmRemove!) {
          cartList.removeAt(index);
        }
        // Utils.showToaster(
        //     context: context, message: "Product removed from cart!");
      }
    }
    emit(state.copyWith(cartItem: cartList));

    event.context.read<CartBloc>().add(UpdateCartTotal());
    saveCartItem(state.cartItem);
  }

  _updateCartTotal(UpdateCartTotal event, Emitter<CartItemState> emit) async {
    double calculatedTotalPrice = 0.0;

    for (var items in state.cartItem) {
      calculatedTotalPrice += (items.price!) * items.quantity.toDouble();
      // calculatedNoItem += items.quantity;
    }

    emit(state.copyWith(totalCartPrice: calculatedTotalPrice));
  }

  _deleteSpecificCart(
      DeleteSpecificCart event, Emitter<CartItemState> emit) async {
    final cartList = List<CartItem>.from(state.cartItem);
    int index = cartList.indexWhere((item) => item.sId == event.productId);
    if (index >= 0) {
      bool? confirmRemove =
          await removeFromCartDialog(index, emit, cartList, event.context);
      if (confirmRemove!) {
        cartList.removeAt(index);
      }
    }
    emit(state.copyWith(cartItem: cartList));
    event.context.read<CartBloc>().add(UpdateCartTotal());
    saveCartItem(state.cartItem);
  }

  saveCartItem(List<CartItem> cartItem) async {
    final cartItemStrings = cartItem.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(cartItemStrings);
    await SessionController().localStorage.setValue("cartItems", jsonString);
  }

  _loadCartItem(LoadCartItem event, Emitter<CartItemState> emit) async {
    final cartItem =
        await SessionController().localStorage.readValue("cartItems");
    if (cartItem != null) {
      final List<dynamic> cartItemJson = jsonDecode(cartItem);
      final oldCartItem = List<CartItem>.from(state.cartItem);
      oldCartItem.clear();
      oldCartItem
          .addAll(cartItemJson.map((e) => CartItem.fromJson(e)).toList());
      event.context.read<CartBloc>().add(UpdateCartTotal());
      saveCartItem(oldCartItem);
      emit(state.copyWith(cartItem: List.from(oldCartItem)));
    } else {
      emit(state.copyWith(cartItem: []));
    }
  }

  // ! show Dialog before completely removing
  Future<bool?> removeFromCartDialog(
    int index,
    Emitter<CartItemState> emit,
    List<CartItem> updatedCartItems,
    final BuildContext context,
  ) async {
    return await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title:  Text("Removing Product",style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black),),
        content: Text(
          "Are you sure you want to remove this product?",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black),
        ),
        actions: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel")),
          OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                state.cartItem.removeAt(index);
                Navigator.pop(context, true);
              },
              child: const Text("Remove"))
        ],
      ),
    );
  }
}
