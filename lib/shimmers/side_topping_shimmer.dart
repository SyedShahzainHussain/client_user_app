import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/shimmers/shimmer_widget.dart';

class SideToppingShimmer extends StatelessWidget {
  const SideToppingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: ShimmerWidget(
              shimmerHieght: 20,
              shimmerWidth: 30,
              shimmerRadius: 0,
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
                  child: ShimmerWidget(
                    shimmerHieght: 100.h,
                    shimmerWidth: 84.w,
                    shimmerRadius: 12.0,
                  ),
                );
              },
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
