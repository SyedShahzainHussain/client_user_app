import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_slider/gradient_slider.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/media_query_extension.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  double value = 0.5;
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
            icon: Icon(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: context.height * 0.3,
                  child: Center(
                    child: Image.asset(
                      ImageString.burgerImage,
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Cheeseburger Wendy's Burger",
                style: TextStyle(
                  color: AppColors.lightoffblack,
                  fontWeight: FontWeight.w600,
                  fontSize: 25.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.secondaryTextColor,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "4.6",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: AppColors.lightoffblack),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 2,
                    width: 10,
                    decoration: const BoxDecoration(color: AppColors.darkGrey),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "26",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: AppColors.lightoffblack),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "mins",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: AppColors.lightoffblack),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "The Cheeseburger Wendy's Burger is a classic fast food burger that packs a punch of flavor in every bite. Made with a juicy beef patty cooked to perfection, it's topped with melted American cheese, crispy lettuce, ripe tomato, and crunchy pickles.",
                style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightblack,
                    letterSpacing: 1),
              ),
              SizedBox(
                height: context.height * 0.03,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                          trackHeight: 8.0,
                          activeTrackGradient: const LinearGradient(colors: [
                            AppColors.redColor,
                            AppColors.redColor,
                          ]),
                          inactiveTrackGradient: const LinearGradient(
                              colors: [Color(0xffF3F4F6), Color(0xffF3F4F6)]),
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
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:AppColors.secondaryTextColor.withOpacity(0.5),
                                  offset: const  Offset(1, 1),
                                  spreadRadius: 0.9,
                                  blurRadius: 0.8,
                                ),
                                
                              ],
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                onPressed: null,
                                icon: SvgPicture.asset(ImageString.line)),
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
                                  color:AppColors.secondaryTextColor.withOpacity(0.5),
                                  offset: const  Offset(1, 1),
                                  spreadRadius: 0.9,
                                  blurRadius: 0.8,
                                ),
                                
                              ],
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                onPressed: null,
                                icon: SvgPicture.asset(ImageString.plus)),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const  EdgeInsets.all(22),
        child: Row(
          children: [
            Container(
              width: 105.w,
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
                      "PKR 899",
                      style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.w,),
             Expanded(

               child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, RouteName.orderScreenName);
                },
                 child: Container(
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightoffblack,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          "ORDER NOW",
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                          ),
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
