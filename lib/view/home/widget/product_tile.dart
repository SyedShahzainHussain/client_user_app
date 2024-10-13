import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/model/product_model.dart';

import '../../../bloc/wishlist/wishlist_bloc.dart';

class ProductTile extends StatelessWidget {
  final Data productModel;

  const ProductTile({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteName.detailScreenName,
              arguments: {"data": productModel});
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
                  child: CachedNetworkImage(
                imageUrl: productModel.images!.first,
                height: context.height * 0.15.h,
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              )),
              Text(
                productModel.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  color: AppColors.lightoffblack,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                productModel.description!,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        productModel.getAverageRating().toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: AppColors.lightoffblack),
                      )
                    ],
                  ),
                  BlocBuilder<WishlistBloc, WishlistState>(
                    builder: (context, state) {
                      bool isInWishlist = state.wishlistProduct
                          .any((product) => product.sId == productModel.sId);

                      return IconButton(
                        onPressed: () {
                          context
                              .read<WishlistBloc>()
                              .add(AddWishlist(productModel));
                        },
                        icon: Icon(isInWishlist
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: AppColors.lightoffblack,
                      );
                    },
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
