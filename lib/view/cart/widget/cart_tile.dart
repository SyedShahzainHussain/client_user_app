import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/auth/profile/profile_bloc.dart';
import 'package:my_app/bloc/cart/cart_bloc.dart';
import 'package:my_app/config/colors.dart';

import '../../../model/cart_item_model.dart';
import 'package:ionicons/ionicons.dart';

class CartTile extends StatelessWidget {
  final CartItem item;
  final Function() onRemove;
  final Function() onAdd;
  const CartTile(
      {super.key,
      required this.item,
      required this.onRemove,
      required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.kcontentColor,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  item.image,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title!,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.category!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$${item.price}",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  context
                      .read<CartBloc>()
                      .add(DeleteSpecificCart(item.sId!, context));
                },
                icon: const Icon(
                  Ionicons.trash_outline,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.kcontentColor,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onRemove,
                      iconSize: 18,
                      icon: const Icon(
                        Ionicons.remove_outline,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      item.quantity.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: onAdd,
                      iconSize: 18,
                      icon: const Icon(
                        Ionicons.add_outline,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
