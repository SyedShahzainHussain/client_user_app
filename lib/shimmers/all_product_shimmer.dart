import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/shimmers/shimmer_widget.dart';
import 'package:my_app/utils/utils.dart';

class AllProductShimmer extends StatelessWidget {
  final int count;
  const AllProductShimmer({super.key, this.count = 4});

  @override
  Widget build(BuildContext context) {
    final columns = Utils.isTablet(context)
        ? 3
        : Utils.isMobile(context)
            ? 2
            : 1;
    final rows = (count / columns).ceil();
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 22.0),
        child: LayoutGrid(
          columnSizes: List.generate(
            columns,
            (_) => 1.fr,
          ),
          rowSizes: List.generate(rows, (_) => auto),
          rowGap: 40, // equivalent to mainAxisSpacing
          columnGap: 24,
          children: [
            for (int i = 0; i < count; i++)
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () {},
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
                          child: ShimmerWidget(
                              shimmerWidth: context.width,
                              shimmerHieght: context.height * 0.15.h,
                              shimmerRadius: 0),
                        ),
                        ShimmerWidget(
                            shimmerWidth: context.width,
                            shimmerHieght: 25,
                            shimmerRadius: 20),
                        ShimmerWidget(
                            shimmerWidth: context.width,
                            shimmerHieght: 25,
                            shimmerRadius: 20),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ShimmerWidget(
                                    shimmerWidth: 40.w,
                                    shimmerHieght: 30.h,
                                    shimmerRadius: 8),
                                SizedBox(
                                  width: 5.w,
                                ),
                                ShimmerWidget(
                                    shimmerWidth: 40.w,
                                    shimmerHieght: 30.h,
                                    shimmerRadius: 8),
                              ],
                            ),
                            ShimmerWidget(
                                shimmerWidth: 40.w,
                                shimmerHieght: 30.h,
                                shimmerRadius: 8),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        )
                      ],
                    ),
                  ),
                ),
              )
          ],
        ));
  }
}
