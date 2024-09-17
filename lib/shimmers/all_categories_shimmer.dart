import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/shimmers/shimmer_widget.dart';

class AllCatergoriesShimmer extends StatelessWidget {
  const AllCatergoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 10),
      height: 50.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return ShimmerWidget(
              shimmerWidth: 80.w,
              shimmerHieght: 80.h,
              shimmerRadius: 12,
            );
          }),
    );
  }
}