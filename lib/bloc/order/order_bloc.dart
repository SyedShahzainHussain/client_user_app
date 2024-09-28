import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/bloc/cart/cart_bloc.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/repository/order/order_api_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderApiRepository orderApiRepository;

  OrderBloc({required this.orderApiRepository})
      : super(const OrderState(postApiStatus: PostApiStatus.initial)) {
    on<PlaceOrderEvent>(_placeOrderEvent);
    on<DeleteCart>(_deleteCart);
  }

  _placeOrderEvent(PlaceOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    final cartListData = event.context.read<CartBloc>().state.cartItem;
    final orderData = {
      "cart": cartListData.map((item) {
        return {
          "product": item.sId,
          "count": item.quantity,
        };
      }).toList()
    };

    await orderApiRepository
        .addToCart(jsonEncode(orderData))
        .then((value) async {
      if (event.context.mounted) {
        await orderApiRepository.placeOrdersApi().then((_) {
          if (event.context.mounted) {
            event.context
                .read<OrderBloc>()
                .add(DeleteCart(context: event.context));
            event.context.read<CartBloc>().add(ClearCartList());
            emit(state.copyWith(postApiStatus: PostApiStatus.success));
          }
        });
      }
    }).onError((error, _) {
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

    await orderApiRepository.clearCart(jsonEncode(itemsToRemove));
  }
}
