import 'dart:convert';

import 'package:http/http.dart' show post;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/bloc/address/address_bloc.dart';
import 'package:my_app/bloc/address/address_event.dart';
import 'package:my_app/bloc/address/address_state.dart';
import 'package:my_app/bloc/auth/profile/profile_bloc.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/utils/utils.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/order/order_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Payment payment = Payment.cash;
  ValueNotifier<bool> checkBoxNotifier = ValueNotifier<bool>(false);

  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required double amount,
      required String currency,
      required String address}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: 'US', testEnv: true),
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        displayPaymentSheet(address: address, amount: amount);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('exception:$e$s');
      }
    }
  }

  displayPaymentSheet({required String address, required double amount}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      if (mounted) {
        context.read<OrderBloc>().add(
            StripePayment(context: context, address: address, amount: amount));
      }
    } on Exception catch (e) {
      if (e is StripeException) {
        if (kDebugMode) {
          print("Error from Stripe: ${e.error.localizedMessage}");
        }
      } else {
        if (kDebugMode) {
          print("Unforeseen error: $e");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("exception:$e");
      }
    }
  }

  createPaymentIntent(double amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51Q5KJwFZrkxj3I7BCQUE2wNyCzIxY3xp7XkfpHXcwQEbmNcU1GWkgOJMLOL2EkDv32OO0F9zQX4TDiSI4z8CVSDh00xNRAkZPT',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      rethrow;
    }
  }

  String calculateAmount(double amount) {
     final int a = (amount * 100).toInt();  // Convert to integer
    return a.toString();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.lightoffblack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              ImageString.search,
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state.postApiStatus == PostApiStatus.loading,
            progressIndicator: SpinKitCircle(
              size: 20.w,
              color: AppColors.buttonColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      context.localizations!.order_summary,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: AppColors.lightoffblack),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    // Todo Order Summary Details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          BlocBuilder<CartBloc, CartItemState>(
                            builder: (context, state) {
                              return RowTitleWidget(
                                title1: context.localizations!.order,
                                price:
                                    "EURO ${state.totalCartPrice.toString()}",
                              );
                            },
                          ),
                          RowTitleWidget(
                            title1: context.localizations!.taxes,
                            price: "22%",
                          ),
                          RowTitleWidget(
                            title1: context.localizations!.delivery_fees,
                            price: "",
                            isFree: true,
                          ),
                          const Divider(
                            color: Color(0xffF0F0F0),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          BlocBuilder<CartBloc, CartItemState>(
                            builder: (context, state) {
                              final totalCartPrice =
                                  state.totalCartPrice; // Get the total price
                              final tax =
                                  totalCartPrice * 0.22; // Calculate 22% tax
                              final totalWithTax =
                                  totalCartPrice + tax; // Add tax to total
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${context.localizations!.total}:",
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.lightoffblack),
                                  ),
                                  Text(
                                    "EURO $totalWithTax",
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.lightoffblack),
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.05,
                    ),

                    // Todo Shipping Address
                    BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state1) {
                        return BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            return Material(
                              elevation: 3.0,
                              color: Colors.white,
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          context
                                              .localizations!.delivery_address,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.sp,
                                              color: AppColors.lightoffblack),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<AddressBloc>()
                                                .add(GetAddress());
                                            Utils.showAddressDialog(context);
                                          },
                                          child: Text(
                                            context.localizations!.change,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15.sp,
                                                color: AppColors.lightoffblack),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: context.height * 0.02,
                                    ),
                                    Text(
                                      state.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: context.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_history,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        state1.selectedAddress == null
                                            ? Flexible(
                                                child: Text(
                                                  state.address,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: Colors.black),
                                                  maxLines: 2,
                                                ),
                                              )
                                            : Flexible(
                                                child: Text(
                                                  state1.selectedAddress!
                                                      .address!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: Colors.black),
                                                  maxLines: 2,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),

                    SizedBox(
                      height: context.height * 0.03,
                    ),

                    // Todo Payment Method
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.localizations!.payment_methods,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                              color: AppColors.lightoffblack),
                        ),
                        SizedBox(
                          height: context.height * 0.02,
                        ),
                        ...Payment.values.map((data) {
                          // Use switch case to handle different Payment enum values
                          String imagePath;
                          String cardNumber;
                          String name;

                          switch (data) {
                            case Payment.visa:
                              imagePath = ImageString.visaImage;
                              cardNumber = "43566 **** **** 0505";
                              name = context.localizations!.visa_card;
                              break;
                            case Payment.cash:
                              imagePath = ImageString.cashImage;
                              cardNumber =
                                  context.localizations!.cash_on_delivery;
                              name = context.localizations!.cash;
                              break;
                          }
                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                payment =
                                    data; // Update the payment method when the container is tapped
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.only(bottom: 20.h),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: payment == data
                                        ? AppColors.secondaryTextColor
                                        : const Color(0xffF3F4F6)),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Image.asset(
                                    imagePath,
                                    width: 70.w,
                                    height: 70.h,
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(name,
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: payment == data
                                                ? Colors.white
                                                : Colors.black,
                                          )),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(cardNumber,
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: payment == data
                                                ? Colors.black
                                                : const Color(0xff808080),
                                          )),
                                    ],
                                  ),
                                  trailing: Radio<Payment>(
                                      activeColor: Colors.white,
                                      focusColor: Colors.white,
                                      fillColor: const WidgetStatePropertyAll(
                                          Colors.white),
                                      visualDensity: VisualDensity.compact,
                                      value: data,
                                      groupValue: payment,
                                      onChanged: (value) {
                                        setState(() {
                                          payment = value!;
                                        });
                                      }),
                                )),
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, addressBloc) {
          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileBloc) {
              return Container(
                margin: const EdgeInsets.all(22),
                child: Row(
                  children: [
                    BlocBuilder<CartBloc, CartItemState>(
                      builder: (context, state) {
                        final totalCartPrice =
                            state.totalCartPrice; // Get the total price
                        final tax = totalCartPrice * 0.22; // Calculate 22% tax
                        final totalWithTax =
                            totalCartPrice + tax; // Add tax to total
                        return Expanded(
                          child: SizedBox(
                            width: 105.w,
                            height: 70.h,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    context.localizations!.total_price,
                                    style: GoogleFonts.roboto(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff808080)),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "EURO ${totalWithTax.toStringAsFixed(0)}",
                                      style: GoogleFonts.roboto(
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    BlocListener<OrderBloc, OrderState>(
                      listener: (context, state) {
                        if (state.postApiStatus == PostApiStatus.success) {
                          Navigator.pushNamed(
                              context, RouteName.placeOrderScreenName);
                          Utils.showToast(context.localizations!
                              .order_has_been_placed_successfully);
                        }
                      },
                      child: BlocBuilder<CartBloc, CartItemState>(
                        builder: (context, state1) {
                          return BlocBuilder<OrderBloc, OrderState>(
                            builder: (context, state) {
                              final totalCartPrice =
                                  state1.totalCartPrice; // Get the total price
                              final tax =
                                  totalCartPrice * 0.22; // Calculate 22% tax
                              final totalWithTax =
                                  totalCartPrice + tax; // Add tax to total
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    // Check if the payment method is Cash or Visa
                                    if (payment == Payment.cash) {
                                      // Place order directly for cash

                                      context.read<OrderBloc>().add(
                                          CashOnDelivery(
                                              context: context,
                                              amount: totalWithTax,
                                              address:
                                                  addressBloc.selectedAddress ==
                                                          null
                                                      ? profileBloc.address
                                                      : addressBloc
                                                          .selectedAddress!
                                                          .address
                                                          .toString()));
                                    } else if (payment == Payment.visa) {
                                      // Initiate Stripe Payment for Visa
                                      await makePayment(
                                          amount: totalWithTax,
                                          currency: 'USD',
                                          address:
                                              addressBloc.selectedAddress ==
                                                      null
                                                  ? profileBloc.address
                                                  : addressBloc
                                                      .selectedAddress!.address
                                                      .toString());
                                    }
                                  },
                                  child: Container(
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.redColor,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: state.postApiStatus ==
                                                PostApiStatus.loading
                                            ? SpinKitCircle(
                                                size: 20.w,
                                                color: Colors.white,
                                              )
                                            : FittedBox(
                                                child: Text(
                                                  context
                                                      .localizations!.order_now,
                                                  style: GoogleFonts.inter(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class RowTitleWidget extends StatelessWidget {
  final String title1;
  final String price;
  final bool isFree;
  const RowTitleWidget({
    super.key,
    required this.title1,
    required this.price,
    this.isFree = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title1,
            style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xff7D7D7D)),
            overflow: TextOverflow.ellipsis,
          ),
          isFree
              ? Text(
                  "Free",
                  style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff7D7D7D)),
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  price,
                  style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff7D7D7D)),
                  overflow: TextOverflow.ellipsis,
                ),
        ],
      ),
    );
  }
}
