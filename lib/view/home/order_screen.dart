import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/utils/utils.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/order/order_bloc.dart';
import '../../services/session_controller_services.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Payment payment = Payment.cash;
  ValueNotifier<bool> checkBoxNotifier = ValueNotifier<bool>(false);

  Future<void> initPaymentSheet() async {
    try {
      Stripe.publishableKey =
          "pk_test_51N17P0BpfnaVUIFxFYuWBLEoZtWqPl3DFdTWFWgDMXTdyIJErhEUJWbP3nKb2OeIIvoTH3H2ahd2Eg1PoQy4fHIK00zdaDUvEE";

      BillingDetails billingDetails = BillingDetails(
        address: const Address(
          city: "Karachi",
          country: "US",
          line1: "addr1",
          line2: "addr2",
          postalCode: "21231",
          state: "Kolango",
        ),
        email: SessionController().userModel.user?.email ?? "",
        name: SessionController().userModel.user?.name ?? "",
        phone: SessionController().userModel.user?.number ?? "",
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          billingDetails: billingDetails,
          merchantDisplayName: 'Prospects',
          paymentIntentClientSecret:
              "pi_3Q5lXiBpfnaVUIFx2UM9wcIN_secret_XfHRb2HdyMToeWvgK0Ik8nFWC",
          customerEphemeralKeySecret:
              "sk_test_51N17P0BpfnaVUIFxHZX2hjXntIdH7IG5AmOQVbWF7GpYVdK30gn2V8ZzgFTCxgrGDDhjDerayvemczNXAOCr1boo00PnNdBd03",
          customFlow: false,
          style: ThemeMode.light,
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            currencyCode: '',
            testEnv: true,
          ),
        ),
      );

      await Stripe.instance.presentPaymentSheet().then((value) {
        if (mounted) {
          context.read<OrderBloc>().add(PlaceOrderEvent(context: context));
        }
      }).onError((error, _) {
        if (error is StripeException) {
          Utils.showToast(error.error.localizedMessage.toString());
        } else {
          Utils.showToast('Stripe Error: $error');
        }
      });
    } catch (e) {
      print(e);
    }
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
            )),
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
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
                        price: state.totalCartPrice.toString(),
                      );
                    },
                  ),
                  RowTitleWidget(
                    title1: context.localizations!.taxes,
                    price: "100",
                  ),
                  RowTitleWidget(
                    title1: context.localizations!.delivery_fees,
                    price: "200",
                  ),
                  const Divider(
                    color: Color(0xffF0F0F0),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  BlocBuilder<CartBloc, CartItemState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${context.localizations!.total}:",
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightoffblack),
                          ),
                          Text(
                            "EURO ${state.totalCartPrice}",
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightoffblack),
                          )
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${context.localizations!.estimated_delivery_time}:",
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightoffblack),
                      ),
                      Text(
                        "15 - 30mins",
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightoffblack),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.height * 0.05,
            ),
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
                  cardNumber = context.localizations!.cash_on_delivery;
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          fillColor: const WidgetStatePropertyAll(Colors.white),
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
            // Row(
            //   children: [
            //     ValueListenableBuilder(
            //         valueListenable: checkBoxNotifier,
            //         builder: (context, data, _) {
            //           return Checkbox(
            //             visualDensity: VisualDensity.compact,
            //             side: const BorderSide(color: AppColors.redColor),
            //             activeColor: AppColors.redColor,
            //             value: checkBoxNotifier.value,
            //             onChanged: (value) {
            //               checkBoxNotifier.value = !checkBoxNotifier.value;
            //             },
            //           );
            //         }),
            //     Text(
            //       "Save card details for future payments",
            //       style: GoogleFonts.roboto(
            //         color: const Color(0xff808080),
            //         fontSize: 16.sp,
            //         fontWeight: FontWeight.w400,
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(22),
        child: Row(
          children: [
            BlocBuilder<CartBloc, CartItemState>(
              builder: (context, state) {
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
                              "EURO ${state.totalCartPrice.toStringAsFixed(0)}",
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
                  Navigator.pushNamed(context, RouteName.placeOrderScreenName);
                  Utils.showToast(context
                      .localizations!.order_has_been_placed_successfully);
                }
              },
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // Check if the payment method is Cash or Visa
                        if (payment == Payment.cash) {
                          // Place order directly for cash
                          context
                              .read<OrderBloc>()
                              .add(PlaceOrderEvent(context: context));
                        } else if (payment == Payment.visa) {
                          // Initiate Stripe Payment for Visa
                          await initPaymentSheet();
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
                            child: state.postApiStatus == PostApiStatus.loading
                                ? SpinKitCircle(
                                    size: 20.w,
                                    color: Colors.white,
                                  )
                                : FittedBox(
                                    child: Text(
                                      context.localizations!.order_now,
                                      style: GoogleFonts.inter(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RowTitleWidget extends StatelessWidget {
  final String title1;
  final String price;
  const RowTitleWidget({
    super.key,
    required this.title1,
    required this.price,
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
          Text(
            "EURO $price",
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
