import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/config/colors.dart';
import 'package:shimmer/shimmer.dart';

class AllBrandShimmer extends StatelessWidget {
  const AllBrandShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 5.0,
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: AppColors.primaryTextColor.withOpacity(0.2),
              child: Container(
                margin: const EdgeInsets.only(right: 12.0, left: 12.0),
                height: 120.h,
                width: 134.w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  const Color(0xff161616).withOpacity(0),
                  const Color(0xffFFFFFF).withOpacity(0),
                  const Color(0xffFF9D01).withOpacity(1),
                ], stops: const [
                  0,
                  0,
                  1
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 80,
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
