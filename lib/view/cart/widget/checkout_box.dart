import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/model/cart_item_model.dart';

import '../../../bloc/cart/cart_bloc.dart';

class CheckOutBox extends StatelessWidget {
  final List<CartItem> items;
  const CheckOutBox({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 10),
      // height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextField(
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(30),
          //       borderSide: BorderSide.none,
          //     ),
          //     contentPadding: const EdgeInsets.symmetric(
          //       vertical: 5,
          //       horizontal: 15,
          //     ),
          //     filled: true,
          //     fillColor: AppColors.kcontentColor,
          //     hintText: "Enter Discount Code",
          //     hintStyle: const TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w600,
          //       color: Colors.grey,
          //     ),
          //     suffixIcon: TextButton(
          //       onPressed: () {},
          //       child: const Text(
          //         "Apply",
          //         style: TextStyle(
          //           color: AppColors.kprimaryColor,
          //           fontSize: 20,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              BlocBuilder<CartBloc, CartItemState>(
                builder: (context, state) {
                  return Text(
                    "${state.totalCartPrice}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  );
                },
              )
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              BlocBuilder<CartBloc, CartItemState>(
                builder: (context, state) {
                  return Text(
                    "${state.totalCartPrice}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  );
                },
              )
            ],
          ),
          const SizedBox(height: 20),
          Button(title: "Check Out", onTap: () {})
        ],
      ),
    );
  }
}
