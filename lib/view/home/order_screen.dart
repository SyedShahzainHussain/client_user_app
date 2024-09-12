import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/media_query_extension.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Payment payment = Payment.visa;
  ValueNotifier<bool> checkBoxNotifier = ValueNotifier<bool>(false);

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
              "Order summary",
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
                  const RowTitleWidget(
                    title1: "Order",
                    price: "899",
                  ),
                  const RowTitleWidget(
                    title1: "Taxes",
                    price: "100",
                  ),
                  const RowTitleWidget(
                    title1: "Delivery fees",
                    price: "200",
                  ),
                  const Divider(
                    color: Color(0xffF0F0F0),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightoffblack),
                      ),
                      Text(
                        "PKR 1200",
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightoffblack),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Estimated delivery time:",
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
              "Payment methods",
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
                  name = "Visa Card";
                  break;
                case Payment.masterCard:
                  imagePath = ImageString.masterImage;
                  cardNumber = "5105 **** **** 0505";
                  name = "Mater Card";
                  break;
              }
              return Container(
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
                              color:
                                  payment == data ? Colors.white : Colors.black,
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
                  ));
            }),
            Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: checkBoxNotifier,
                    builder: (context, data, _) {
                      return Checkbox(
                        visualDensity: VisualDensity.compact,
                        side: const BorderSide(color: AppColors.redColor),
                        activeColor: AppColors.redColor,
                        value: checkBoxNotifier.value,
                        onChanged: (value) {
                          checkBoxNotifier.value = !checkBoxNotifier.value;
                        },
                      );
                    }),
                Text(
                  "Save card details for future payments",
                  style: GoogleFonts.roboto(
                    color: const Color(0xff808080),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(22),
        child: Row(
          children: [
            Expanded(
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
                        "Total price",
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: const  Color(0xff808080)
                        ),
                      ),
                       SizedBox(
                        height: 3.h,
                      ),
                      Expanded(
                        child: Text(
                          "PKR 899",
                          style: GoogleFonts.roboto(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.submitScreenName);
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
                      child: FittedBox(
                        child: Text(
                          "Pay Now",
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
      margin: EdgeInsets.only(bottom: 5),
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
            "PKR $price",
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
