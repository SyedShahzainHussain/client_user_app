import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_slider/gradient_slider.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/extension/media_query_extension.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  double value = 0.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
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
                            Image.network(
                              "https://res.cloudinary.com/dll3s3l73/image/upload/v1726486604/zpd8igdymtterozp3rta.jpg",
                              height: context.height * .3,
                              fit: BoxFit.fitHeight,
                              width: double.infinity,
                            ),
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
                                  " Your Burger to Your Tastes. Ultimate Experience",
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
                          Column(
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
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.secondaryTextColor
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
                                        icon:
                                            SvgPicture.asset(ImageString.line)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      "2",
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
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.secondaryTextColor
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
                                        icon:
                                            SvgPicture.asset(ImageString.plus)),
                                  )
                                ],
                              )
                            ],
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
                  SizedBox(
                    height: 100.h,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.w,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(15.r),
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
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Center(
                                    child: Image.network(
                                      "https://www.simplyrecipes.com/thmb/Oikw9O41IDWOFmuJZQ2bs8dGVB8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2009__01__how-to-slice-onion-horiz-a2-1800-1ff872c2194e49169812d2fcbc1f3e6c.jpg",
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
                                      Text(
                                        "Onions",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        width: 16.w,
                                        height: 16.w,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffEF2A39),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
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
                  SizedBox(
                    height: 100.h,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.w,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(15.r),
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
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Center(
                                    child: Image.network(
                                      "https://www.simplyrecipes.com/thmb/Oikw9O41IDWOFmuJZQ2bs8dGVB8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2009__01__how-to-slice-onion-horiz-a2-1800-1ff872c2194e49169812d2fcbc1f3e6c.jpg",
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
                                      Text(
                                        "Onions",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        width: 16.w,
                                        height: 16.w,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffEF2A39),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  ),
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
              Column(
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
                          text: "16.48",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ))
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
