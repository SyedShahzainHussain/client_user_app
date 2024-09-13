
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/media_query_extension.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      child: GestureDetector(
        onTap: (){
           Navigator.pushNamed(context, RouteName.detailScreenName);
    
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                ImageString.burgerImage,
                height: context.height * 0.15.h,
              )),
              Text(
                "Cheeseburger",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  color: AppColors.lightoffblack,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Wendy's Burger",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  color: AppColors.lightoffblack,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
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
                  const Icon(
                    Icons.favorite_border,
                    color: AppColors.lightoffblack,
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
