import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/shimmers/shimmer_widget.dart';

class AllBrandsShimmer extends StatelessWidget {
  const AllBrandsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r), color: Colors.white),
        child: Column(
          children: [
            const Divider(
              color: Color(0xffF4F5F7),
            ),
            SizedBox(
              height: context.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget(
                  shimmerWidth: 50,
                  shimmerHieght: 50,
                  shimmerRadius: 12.r,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ShimmerWidget(
                          shimmerWidth: 100,
                          shimmerHieght: 30,
                          shimmerRadius: 12.r,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ShimmerWidget(
                          shimmerWidth: 30,
                          shimmerHieght: 30,
                          shimmerRadius: 22.r,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    ShimmerWidget(
                      shimmerWidth: double.infinity,
                      shimmerHieght: 20,
                      shimmerRadius: 22.r,
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    ShimmerWidget(
                      shimmerWidth: double.infinity,
                      shimmerHieght: 20,
                      shimmerRadius: 22.r,
                    ),
                  ],
                ))
              ],
            ),
            SizedBox(
              height: context.height * 0.02,
            ),
            ShimmerWidget(
              shimmerWidth: double.infinity,
              shimmerHieght: 30,
              shimmerRadius: 22.r,
            ),
          ],
        ));
  }
}
