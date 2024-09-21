import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/bloc/auth/profile/profile_bloc.dart';
import 'package:my_app/bloc/brand/brand_bloc.dart';
import 'package:my_app/bloc/wishlist/wishlist_bloc.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/data/response/status.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/extension/string_extension.dart';
import 'package:my_app/shimmers/all_brand_shimmer.dart';
import 'package:my_app/shimmers/all_categories_shimmer.dart';
import 'package:my_app/shimmers/all_product_shimmer.dart';
import 'package:my_app/utils/utils.dart';
import 'package:my_app/view/home/widget/product_tile.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import '../../bloc/category/category_bloc.dart';
import '../../bloc/products/product_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfileData());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Colors.black,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
        if (context.mounted) {
          context.read<CategoryBloc>().add(FetchCategory());
          context.read<ProductBloc>().add(const GetAllProducts("All"));
          context.read<BrandBloc>().add(GetAllBrand());
          context.read<WishlistBloc>().add(GetWishlist());
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
            leading: Container(
              margin: const EdgeInsets.only(left: 12.0),
              child: Image.asset(ImageString.logoImage),
            ),
            actions: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: AppColors.primaryColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedNetworkImage(
                        imageUrl: state.profilePic.isEmpty
                            ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"
                            : state.profilePic.toString(),
                        fit: BoxFit.cover,
                        width: 50.w,
                        height: 50.h,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: BlocListener<WishlistBloc, WishlistState>(
            listenWhen: (previous, current) =>
                previous.postApiStatus != current.postApiStatus &&
                previous.message != current.message,
            listener: (context, state) {
              if (state.postApiStatus == PostApiStatus.success) {
                Utils.showToast(state.message);
              }
            },
            child: BlocBuilder<WishlistBloc, WishlistState>(
              builder: (context, state) {
                return ModalProgressHUD(
                  inAsyncCall: state.postApiStatus == PostApiStatus.loading,
                  progressIndicator: SpinKitCircle(
                    size: 20.w,
                    color: AppColors.buttonColor,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: kBottomNavigationBarHeight + 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 22.0),
                            child: Text(
                              context.localizations!.orderYourFavouriteFood,
                              style: TextStyle(
                                color: AppColors.lightblack,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.height * 0.05,
                          ),
                          // Todo Search Food
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 22.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: SizedBox(
                                      height: 60.h,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteName.searchScreenName);
                                        },
                                        child: TextFormField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            hintText:
                                                context.localizations!.search,
                                            hintStyle: TextStyle(
                                              color: AppColors.lightoffblack,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.sp,
                                            ),
                                            prefixIcon: IconButton(
                                                onPressed: null,
                                                icon: SvgPicture.asset(
                                                    ImageString.search)),
                                          ),
                                          style: TextStyle(
                                            color: AppColors.lightoffblack,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.sp,
                                          ),
                                          cursorColor: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                      color: AppColors.redColor,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: SvgPicture.asset(ImageString.filter),
                                  )),
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: context.height * 0.05,
                          ),
                          BlocBuilder<CategoryBloc, CategoryState>(
                            builder: (context, state) {
                              switch (state.categoryList.status) {
                                case Status.loading:
                                  return const AllCatergoriesShimmer();
                                case Status.complete:
                                  return state.categoryList.data!.isEmpty
                                      ? Center(
                                          child: Text(
                                            context
                                                .localizations!.noCategoryFound,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.black),
                                          ),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: SizedBox(
                                            height: 50.h,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                final category =
                                                    state.categoryList.data!;
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (state.category ==
                                                        category[index].sId) {
                                                      // BlocProvider.of<
                                                      //             CategoryBloc>(
                                                      //         context)
                                                      //     .add(
                                                      //         ClearCategoryValue());
                                                      // context
                                                      //     .read<ProductBloc>()
                                                      //     .add(
                                                      //         const GetAllProducts(
                                                      //             "All"));
                                                    } else if (category[index]
                                                            .title!
                                                            .toLowerCase() ==
                                                        "all") {
                                                      BlocProvider.of<
                                                                  CategoryBloc>(
                                                              context)
                                                          .add(
                                                        SetCategoryAndTitleEvent(
                                                            category:
                                                                category[index]
                                                                    .sId!,
                                                            title:
                                                                category[index]
                                                                    .title!),
                                                      );
                                                      context
                                                          .read<ProductBloc>()
                                                          .add(
                                                              const GetAllProducts(
                                                                  "All"));
                                                    } else {
                                                      BlocProvider.of<
                                                                  CategoryBloc>(
                                                              context)
                                                          .add(
                                                        SetCategoryAndTitleEvent(
                                                            category:
                                                                category[index]
                                                                    .sId!,
                                                            title:
                                                                category[index]
                                                                    .title!),
                                                      );
                                                      context
                                                          .read<ProductBloc>()
                                                          .add(GetAllProducts(
                                                              category[index]
                                                                  .title!
                                                                  .toLowerCase()));
                                                    }
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5.0),
                                                    height: 50.h,
                                                    width: 80.w,
                                                    decoration: BoxDecoration(
                                                        boxShadow: state
                                                                .category
                                                                .contains(
                                                                    category[
                                                                            index]
                                                                        .sId!)
                                                            ? const [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black54,
                                                                  offset:
                                                                      Offset(
                                                                          0, 1),
                                                                  blurRadius:
                                                                      1.0,
                                                                  spreadRadius:
                                                                      1.5,
                                                                ),
                                                              ]
                                                            : null,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        color: state.category
                                                                .contains(
                                                                    category[
                                                                            index]
                                                                        .sId!)
                                                            ? AppColors.redColor
                                                            : const Color(
                                                                0xffF3F4F6)),
                                                    child: Center(
                                                      child: Text(
                                                        category[index]
                                                            .title
                                                            .toString()
                                                            .capitalized,
                                                        style: GoogleFonts.inter(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: state
                                                                    .category
                                                                    .contains(
                                                                        category[index]
                                                                            .sId!)
                                                                ? Colors.white
                                                                : AppColors
                                                                    .lightblack),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: state
                                                  .categoryList.data!.length,
                                            ),
                                          ),
                                        );
                                case Status.error:
                                  return Center(
                                    child: Text(
                                      state.categoryList.message.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.black),
                                    ),
                                  );
                                default:
                                  return const SizedBox();
                              }
                            },
                          ),
                          SizedBox(
                            height: context.height * 0.03,
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 22.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  context.localizations!.popularFoods,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteName.allProductScreenName);
                                  },
                                  child: Text(
                                    context.localizations!.viewAll,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: context.height * 0.03,
                          ),
                          BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              switch (state.allProrducts.status) {
                                case Status.loading:
                                  return const AllProductShimmer();
                                case Status.complete:
                                  final displayedItem =
                                      state.allProrducts.data!.data!.length > 4
                                          ? state.allProrducts.data!.data!
                                              .sublist(0, 4)
                                          : state.allProrducts.data!.data;
                                  final columns = Utils.isTablet(context)
                                      ? 3
                                      : Utils.isMobile(context)
                                          ? 2
                                          : 1;
                                  final rows =
                                      (displayedItem!.length / columns).ceil();
                                  return displayedItem.isEmpty
                                      ? Center(
                                          child: Text(context
                                              .localizations!.noProductFound),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0, right: 22.0),
                                          child: LayoutGrid(
                                            columnSizes: List.generate(
                                              columns,
                                              (_) => 1.fr,
                                            ),
                                            rowSizes: List.generate(
                                                rows, (_) => auto),
                                            rowGap:
                                                40, // equivalent to mainAxisSpacing
                                            columnGap: 24,
                                            children: [
                                              for (var product in displayedItem)
                                                ProductTile(
                                                  productModel: product,
                                                )
                                            ],
                                          ));
                                case Status.error:
                                  return Center(
                                    child: Text(
                                      state.allProrducts.message.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.black),
                                    ),
                                  );
                                default:
                                  return const SizedBox();
                              }
                            },
                          ),
                          SizedBox(
                            height: context.height * 0.03,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 22.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  context.localizations!.popularMoodsYouCanGet,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                                // Text(
                                //   "view all",
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.w400,
                                //     fontSize: 16.sp,
                                //     color: AppColors.secondaryTextColor,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: context.height * 0.03,
                          ),
                          // Todo Brand

                          BlocBuilder<BrandBloc, BrandState>(
                            builder: (context, state) {
                              switch (state.getAllBrand.status) {
                                case Status.loading:
                                  return const AllBrandShimmer();
                                case Status.complete:
                                  return SizedBox(
                                    height: 102.h,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Material(
                                            elevation: 3.0,
                                            color: Colors.white,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    RouteName
                                                        .allBrandScreenName);
                                              },
                                              child: Container(
                                                height: 102.h,
                                                width: 134.w,
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        colors: [
                                                      const Color(0xff161616)
                                                          .withOpacity(0),
                                                      const Color(0xffFFFFFF)
                                                          .withOpacity(0),
                                                      const Color(0xffFF9D01)
                                                          .withOpacity(1),
                                                    ],
                                                        stops: const [
                                                      0,
                                                      0,
                                                      1
                                                    ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter)),
                                                child: Column(
                                                  children: [
                                                    CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: state
                                                          .getAllBrand
                                                          .data![index]
                                                          .image!,
                                                      height: 55.h,
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                        state
                                                            .getAllBrand
                                                            .data![index]
                                                            .title!,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16,
                                                        )),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount:
                                            state.getAllBrand.data!.length,
                                      ),
                                    ),
                                  );
                                case Status.error:
                                  return Center(
                                    child: Text(
                                      state.getAllBrand.message.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: Colors.black),
                                    ),
                                  );
                                default:
                                  return const SizedBox();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
