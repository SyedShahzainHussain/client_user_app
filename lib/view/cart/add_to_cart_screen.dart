import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_slider/gradient_slider.dart';
import 'package:my_app/bloc/side_topping/side_topping_bloc.dart';
import 'package:my_app/bloc/side_topping/side_topping_event.dart';
import 'package:my_app/bloc/side_topping/side_topping_state.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/data/response/status.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/model/cart_item_model.dart';
import 'package:my_app/shimmers/side_topping_shimmer.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../model/product_model.dart';
import 'package:badges/badges.dart' as badges;

class AddToCartScreen extends StatefulWidget {
  final Data data;
  const AddToCartScreen({super.key, required this.data});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  double value = 0.5;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Trigger the data fetch each time the dependencies change
    context
        .read<CartBloc>()
        .add(GetSpecificProductQuantity(productId: widget.data.sId!));

    context.read<CartBloc>().add(GetAllToppingsAccordingToTheirCategory(
          category: widget.data.category!,
        ));

    context.read<SideToppingBloc>().add(FetchAllSideTopping());
  }

  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.read<SideToppingBloc>().add(ClearSideToppins());
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          onLeadingPress: () {
            context.read<SideToppingBloc>().add(ClearSideToppins());
            Navigator.pop(context);
          },
          actions: [
            BlocBuilder<CartBloc, CartItemState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteName.cartScreenName,
                            arguments: true);
                      },
                      icon: badges.Badge(
                        badgeContent: Text(state.cartItem.length.toString()),
                        child: const Icon(Icons.shopping_cart),
                      )),
                );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: context.height * .3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: widget.data.images!.first,
                                height: context.height * .3,
                                fit: BoxFit.fitHeight,
                                width: double.infinity,
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(left: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: "Customize",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16.sp,
                                    color: AppColors.lightoffblack),
                              ),
                              TextSpan(
                                text:
                                    " Your ${widget.data.category} to Your Tastes. Ultimate Experience",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.lightoffblack,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ])),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text("Spicy",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.lightoffblack,
                                      )),
                                ),
                                SizedBox(
                                  width: context.width * .4,
                                  height: 30,
                                  child: GradientSlider(
                                    thumbAsset: ImageString.silderbuttonImage,
                                    trackBorderColor: Colors.transparent,
                                    trackHeight: 4.0,
                                    activeTrackGradient:
                                        const LinearGradient(colors: [
                                      AppColors.redColor,
                                      AppColors.redColor,
                                    ]),
                                    inactiveTrackGradient: const LinearGradient(
                                        colors: [
                                          Color(0xffF3F4F6),
                                          Color(0xffF3F4F6)
                                        ]),
                                    slider: Slider(
                                        value: value,
                                        onChanged: (value) {
                                          setState(() {
                                            this.value = value;
                                          });
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  width: context.width * .4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Mild",
                                          style: GoogleFonts.roboto(
                                            color: const Color(0xff1CC019),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Hot",
                                          style: GoogleFonts.roboto(
                                            color: const Color(0xffEF2A39),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            BlocBuilder<CartBloc, CartItemState>(
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Portion",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff3C2F2F),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<CartBloc>()
                                                .add(DecrementCount());
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors
                                                        .secondaryTextColor
                                                        .withOpacity(0.5),
                                                    offset: const Offset(1, 1),
                                                    spreadRadius: 0.9,
                                                    blurRadius: 0.8,
                                                  ),
                                                ],
                                                color: AppColors.redColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: IconButton(
                                                onPressed: null,
                                                icon: SvgPicture.asset(
                                                    ImageString.line)),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            state.noOfCartItem.toString(),
                                            style: GoogleFonts.inter(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.lightoffblack,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<CartBloc>()
                                                .add(IncrementCount());
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors
                                                        .secondaryTextColor
                                                        .withOpacity(0.5),
                                                    offset: const Offset(1, 1),
                                                    spreadRadius: 0.9,
                                                    blurRadius: 0.8,
                                                  ),
                                                ],
                                                color: AppColors.redColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: IconButton(
                                                onPressed: null,
                                                icon: SvgPicture.asset(
                                                    ImageString.plus)),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
              // Todo Toppins Widget
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Toppings",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.lightoffblack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlocBuilder<CartBloc, CartItemState>(
                      builder: (context, state) {
                        return SizedBox(
                          height: 100.h,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10.w,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final toppins = widget.data.toppings![index];
                              bool isSelected = state.selectedToppings
                                  .any((data) => data.sId == toppins.sId);
                              return Material(
                                elevation: 3.0,
                                borderRadius: BorderRadius.circular(15.r),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<CartBloc>().add(AddTopping(
                                          toppingModel:
                                              widget.data.toppings![index],
                                          context: context,
                                        ));
                                    context.read<CartBloc>().add(
                                        GetAllToppingsAccordingToTheirCategory(
                                            category: widget.data.category!));
                                  },
                                  child: Container(
                                    height: 100.h,
                                    width: 84.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff3C2F2F),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 84.w,
                                          height: 61.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Center(
                                            child: CachedNetworkImage(
                                              imageUrl: toppins.image!,
                                              width: 55.w,
                                              height: 45.91.h,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: FittedBox(
                                                  child: Text(
                                                    toppins.title!,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              SizedBox(
                                                width: 16.w,
                                                height: 16.w,
                                                child: Checkbox(
                                                  value: isSelected,
                                                  onChanged: (bool? value) {
                                                    context
                                                        .read<CartBloc>()
                                                        .add(AddTopping(
                                                          toppingModel: widget
                                                              .data
                                                              .toppings![index],
                                                          context: context,
                                                        ));
                                                    context.read<CartBloc>().add(
                                                        GetAllToppingsAccordingToTheirCategory(
                                                            category: widget
                                                                .data
                                                                .category!));
                                                  },
                                                  checkColor: Colors.white,
                                                  activeColor: Colors.red,
                                                  overlayColor:
                                                      const WidgetStatePropertyAll(
                                                          Colors.grey),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: widget.data.toppings!.length,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              // Todo Side Options
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Side options",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.lightoffblack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlocBuilder<SideToppingBloc, SideToppingState>(
                        builder: (context, state) {
                      switch (state.getAllSideToppings.status) {
                        case Status.loading:
                          return const SideToppingShimmer();
                        case Status.complete:
                          return SizedBox(
                            height: 110.h,
                            child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                width: 10.w,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final sideToppings =
                                    state.getAllSideToppings.data!;
                                bool isSelected = state.selectedSideToppings
                                    .any((data) =>
                                        data.sId == sideToppings[index].sId);
                                return Material(
                                  elevation: 3.0,
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<SideToppingBloc>().add(
                                          AddSideToppingEvent(
                                              sideToppings[index]));
                                      context
                                          .read<SideToppingBloc>()
                                          .add(GetTotalPrice());
                                    },
                                    child: Container(
                                      height: 100.h,
                                      width: 84.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff3C2F2F),
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 84.w,
                                            height: 61.h,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: Center(
                                              child: Image.network(
                                                sideToppings[index].image!,
                                                width: 55.w,
                                                height: 45.91.h,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "price",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                Text(
                                                  "\$${sideToppings[index].price}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  sideToppings[index].title!,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16.w,
                                                  height: 16.w,
                                                  child: Checkbox(
                                                    value: isSelected,
                                                    onChanged: (bool? value) {
                                                      context
                                                          .read<
                                                              SideToppingBloc>()
                                                          .add(
                                                              AddSideToppingEvent(
                                                                  sideToppings[
                                                                      index]));
                                                      context
                                                          .read<
                                                              SideToppingBloc>()
                                                          .add(GetTotalPrice());
                                                    },
                                                    checkColor: Colors.white,
                                                    activeColor: Colors.red,
                                                    overlayColor:
                                                        const WidgetStatePropertyAll(
                                                            Colors.grey),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: state.getAllSideToppings.data!.length,
                            ),
                          );
                        case Status.error:
                          return Center(
                            child: Text(
                                state.getAllSideToppings.message.toString()),
                          );
                        default:
                          return const SizedBox();
                      }
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight + 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                BlocBuilder<SideToppingBloc, SideToppingState>(
                  builder: (context, state1) {
                    return BlocBuilder<CartBloc, CartItemState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                color: const Color(0xff3C2F2F),
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                              ),
                            ),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: "\$",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                                TextSpan(
                                    text:
                                        "${(widget.data.price! + state1.totalPrice) * state.noOfCartItem}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 36.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            ))
                          ],
                        );
                      },
                    );
                  },
                ),
                const Spacer(),
                BlocBuilder<SideToppingBloc, SideToppingState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        final cartItem = CartItem(
                            sId: widget.data.sId,
                            title: widget.data.title,
                            description: widget.data.description,
                            price:
                                widget.data.price! + state.totalPrice.toInt(),
                            category: widget.data.category,
                            brand: widget.data.brand,
                            image: widget.data.images!.first,
                            quantity:
                                context.read<CartBloc>().state.noOfCartItem,
                            selectedToppings: context
                                .read<CartBloc>()
                                .state
                                .getselectedToppingsAccordingToThereCategory,
                            selectedSideToppings: context
                                .read<SideToppingBloc>()
                                .state
                                .selectedSideToppings);
                        context
                            .read<CartBloc>()
                            .add(AddToCart(cartItem, context));
                        // context.read<SideToppingBloc>().add(ClearSideToppins());
                        // context.read<CartBloc>().add(ClearSideToppins());
                      },
                      child: Container(
                        height: 70.h,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                "Add to cart",
                                style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
