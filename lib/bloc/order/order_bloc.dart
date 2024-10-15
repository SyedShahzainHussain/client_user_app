import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/bloc/cart/cart_bloc.dart';
import 'package:my_app/bloc/side_topping/side_topping_bloc.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/model/order_model.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/repository/order/order_api_repository.dart';
import 'package:my_app/repository/side_topping/side_topping_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderApiRepository orderApiRepository;

  OrderBloc({required this.orderApiRepository})
      : super(const OrderState(postApiStatus: PostApiStatus.initial)) {
    on<PlaceOrderEvent>(_placeOrderEvent);
    on<DeleteCart>(_deleteCart);
    on<CashOnDelivery>(_cashOnDelivery);
    on<StripePayment>(_stripePayment);
    on<GetOrder>(_getOrderList);
  }

  _placeOrderEvent(PlaceOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    final cartListData = event.context.read<CartBloc>().state.cartItem;

    final selectedToppings =
        event.context.read<CartBloc>().state.selectedToppings;

    final selectedSideToppings =
        event.context.read<SideToppingBloc>().state.selectedSideToppings;

    final orderData = {
      "cart": cartListData.map((item) {
        final topping = selectedToppings.firstWhere(
          (t) => t.sId == item.sId,
          orElse: () => Toppings().empty(),
        );
        final sideTopping = selectedSideToppings.firstWhere(
          (st) => st.sId == item.sId,
          orElse: () => SideToppins().empty(),
        );

        return {
          "product": item.sId,
          "count": item.quantity,
          "topping": topping.sId,
          "sidetopping": sideTopping.sId,
        };
      }).toList()
    };

    await orderApiRepository
        .addToCart(jsonEncode(orderData))
        .then((value) async {})
        .onError((error, _) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    });
  }

  _deleteCart(DeleteCart event, Emitter<OrderState> emit) async {
    final cartListData = event.context.read<CartBloc>().state.cartItem;
    final itemsToRemove = {
      "itemsToRemove": cartListData.map((e) {
        return {
          "id": e.sId,
        };
      }).toList()
    };

    await orderApiRepository.clearCart(jsonEncode(itemsToRemove)).then((_) {
      if (event.context.mounted) {}
    });
  }

  _cashOnDelivery(CashOnDelivery event, Emitter<OrderState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    final body = {"amount": event.amount, "address": event.address};

    final cartListData = event.context.read<CartBloc>().state.cartItem;

    final orderData = {
      "cart": cartListData.map((item) {
        // Pick the first topping from the list, or use null/empty if the list is empty
        final topping =
            (item.selectedToppings != null && item.selectedToppings!.isNotEmpty)
                ? item.selectedToppings!.first
                : null;

        // Pick the first side topping from the list, or use null/empty if the list is empty
        final sideTopping = (item.selectedSideToppings != null &&
                item.selectedSideToppings!.isNotEmpty)
            ? item.selectedSideToppings!.first
            : null;
        return {
          "product": item.sId,
          "count": item.quantity,
          "topping": topping!.sId,
          "sidetopping": sideTopping!.sId,
        };
      }).toList()
    };

    await orderApiRepository.addToCart(jsonEncode(orderData));

    await orderApiRepository.checkOutOrder(body).then((value) {
      if (event.context.mounted) {
        event.context.read<CartBloc>().add(ClearCartList());
        emit(state.copyWith(postApiStatus: PostApiStatus.success));
      }
    }).onError((error, _) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    });
  }

  _stripePayment(StripePayment event, Emitter<OrderState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    final body = {"amount": event.amount, "address": event.address};

    final cartListData = event.context.read<CartBloc>().state.cartItem;

    final selectedToppings =
        event.context.read<CartBloc>().state.selectedToppings;

    final selectedSideToppings =
        event.context.read<SideToppingBloc>().state.selectedSideToppings;

    final orderData = {
      "cart": cartListData.map((item) {
        final topping = selectedToppings.firstWhere(
          (t) => t.sId == item.sId,
          orElse: () => Toppings().empty(),
        );
        final sideTopping = selectedSideToppings.firstWhere(
          (st) => st.sId == item.sId,
          orElse: () => SideToppins().empty(),
        );

        return {
          "product": item.sId,
          "count": item.quantity,
          "topping": topping.sId,
          "sidetopping": sideTopping.sId,
        };
      }).toList()
    };

    await orderApiRepository.addToCart(jsonEncode(orderData));

    await orderApiRepository.checkOutStripeOrder(body).then((value) {
      if (event.context.mounted) {
        event.context.read<CartBloc>().add(ClearCartList());
        emit(state.copyWith(postApiStatus: PostApiStatus.success));
      }
    }).onError((error, _) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    });
  }

  _getOrderList(GetOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    await orderApiRepository.getOrders().then((value) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.success, getOrderList: value));
    }).onError((error, _) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    });
  }
}
