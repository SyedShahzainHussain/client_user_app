import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_app/bloc/order/order_bloc.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/common/t_rounded_container.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/model/order_model.dart';
import 'package:my_app/utils/utils.dart';

class GetOrderScreen extends StatefulWidget {
  const GetOrderScreen({super.key});

  @override
  State<GetOrderScreen> createState() => _GetOrderScreenState();
}

class _GetOrderScreenState extends State<GetOrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetOrder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: context.localizations!.my_orders,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
            switch (state.postApiStatus) {
              case PostApiStatus.loading:
                return const Center(
                  child: TRoundedContainer(
                    padding: EdgeInsets.all(12),
                    width: 50,
                    height: 50,
                    backgroundColor: AppColors.redColor,
                    showBorder: true,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeCap: StrokeCap.round,
                      strokeWidth: 3.0,
                    ),
                  ),
                );
              case PostApiStatus.success:
                return state.getOrderList.isEmpty
                    ? const Center(child: Text("No Order Found"))
                    : ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 16.0,
                            ),
                        itemCount: state.getOrderList.length,
                        itemBuilder: (context, index) {
                          final orders = state.getOrderList[index];
                          return OrderTile(orders: orders);
                        });
              case PostApiStatus.error:
                return Center(
                  child: Text(state.message),
                );
              default:
                return const SizedBox();
            }
          }),
        ));
  }
}

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.orders,
  });

  final OrderModel orders;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: const Color(0xFFF6F6F6),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ! Row -> 1
          Row(
            children: [
              // ! Icon
              const Icon(Iconsax.ship),
              const SizedBox(
                width: 16.0 / 2,
              ),
              // !  2 -  Status & Date
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orders.orderStatus!,
                      style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: AppColors.redColor,
                            fontWeightDelta: 1,
                          ),
                    ),
                    Text(
                      orders.orderby!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                      maxLines: 1,
                    )
                  ],
                ),
              ),
              // ! 3 - Icon
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Iconsax.arrow_right_34,
                    size: 16.0,
                  ))
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          // ! Row -> 1
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // ! Icon
                    const Icon(Iconsax.tag),
                    const SizedBox(
                      width: 16.0 / 2,
                    ),
                    // !  2 -  Status & Date
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order",
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.black)),
                          Text(
                            "#${orders.sId!.substring(0, 6)}",
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    // ! Icon
                    const Icon(Iconsax.calendar),
                    const SizedBox(
                      width: 16.0 / 2,
                    ),
                    // !  2 -  Status & Date
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Shopping Date",
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.black)),
                          Text(
                            Utils().formatDate(orders.createdAt!),
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
