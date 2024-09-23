import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/view/cart/widget/cart_tile.dart';
import 'package:my_app/view/cart/widget/checkout_box.dart';

import '../../bloc/cart/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          isLeading: false,
          title: "Cart",
        ),
        bottomSheet: BlocBuilder<CartBloc, CartItemState>(
          builder: (context, state) {
            return state.cartItem.isNotEmpty
                ? CheckOutBox(
                    items: state.cartItem,
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
