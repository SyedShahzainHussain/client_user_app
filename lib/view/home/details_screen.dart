import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/extension/media_query_extension.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

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
                      decoration:
                          const BoxDecoration(color: AppColors.darkGrey),
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
                            letterSpacing: 1
                          ),
                        )
              ],
            ),
          ),
        ));
  }
}
