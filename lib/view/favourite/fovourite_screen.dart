import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/bloc/wishlist/wishlist_bloc.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/data/response/status.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/shimmers/all_product_shimmer.dart';
import 'package:my_app/utils/utils.dart';
import 'package:my_app/view/home/widget/product_tile.dart';


class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(GetWishlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Favourite",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.black),
        ),
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<WishlistBloc, WishlistState>(
        listenWhen: (previous, current) =>
            previous.postApiStatus != current.postApiStatus &&
            previous.message != current.message,
        listener: (context, state) {
          if (state.postApiStatus == PostApiStatus.success) {
            Utils.showToast(state.message);
            context.read<WishlistBloc>().add(GetWishlist());
            setState(() {});
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
                        bottom: kBottomNavigationBarHeight),
                    child: BlocBuilder<WishlistBloc, WishlistState>(
                        builder: (context, data) {
                      switch (data.backendWishListProducts.status) {
                        case Status.loading:
                          return const AllProductShimmer(
                            count: 10,
                          );
                        case Status.complete:
                          final productList = data.backendWishListProducts.data;
                          if (productList == null || productList.isEmpty) {
                            return Column(
                              children: [
                                SizedBox(height: context.height * .4),
                                Center(
                                  child: Text(
                                    "Your wishlist is empty!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            );
                          }
                          final columns = Utils.isTablet(context)
                              ? 3
                              : Utils.isMobile(context)
                                  ? 2
                                  : 1;
                          final rows = (productList.length / columns).ceil();
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              right: 22.0,
                            ),
                            child: LayoutGrid(
                              columnSizes: List.generate(
                                columns,
                                (_) => 1.fr,
                              ),
                              rowSizes: List.generate(rows, (_) => auto),
                              rowGap: 40,
                              columnGap: 24,
                              children: [
                                for (var product in productList)
                                  ProductTile(
                                    productModel: product,
                                    
                                  )
                              ],
                            ),
                          );
                        case Status.error:
                          return Center(
                            child: Text(
                              data.backendWishListProducts.message.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          );
                        default:
                          return const SizedBox();
                      }
                    })),
              ),
            );
          },
        ),
      ),
    );
  }
}
