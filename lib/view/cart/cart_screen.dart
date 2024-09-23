import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/view/cart/widget/cart_tile.dart';
import 'package:my_app/view/cart/widget/checkout_box.dart';

import '../../bloc/cart/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  final bool isPushing;
  const CartScreen({super.key, this.isPushing = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          isLeading: isPushing == true ? true : false,
          title: "Cart",
        ),
        bottomSheet:BlocBuilder<CartBloc, CartItemState>(
                builder: (context, state) {
                  return state.cartItem.isNotEmpty
                      ? isPushing?  CheckOutBox(
                          items: state.cartItem,
                        ): Container(
                        margin: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                          child: CheckOutBox(
                            items: state.cartItem,
                          ),
                        )
                      : const SizedBox();
                },
              ),
  
        body: BlocBuilder<CartBloc, CartItemState>(
          builder: (context, state) {
            final cart = state.cartItem;
            return cart.isEmpty
                ? Center(
                    child: Text(
                      "No Cart Found",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      return CartTile(
                          item: cart[index],
                          onDelete: () {
                            context.read<CartBloc>().add(
                                DeleteSpecificCart(cart[index].sId!, context));
                          },
                          onRemove: () {
                            context
                                .read<CartBloc>()
                                .add(RemoveFromCart(cart[index].sId!, context));
                          },
                          onAdd: () {
                            context
                                .read<CartBloc>()
                                .add(AddOneToCart(cart[index], context));
                          });
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: state.cartItem.length);
          },
        ));
  }
}
