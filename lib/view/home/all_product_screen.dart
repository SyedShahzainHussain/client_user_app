import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/bloc/products/product_bloc.dart';
import 'package:my_app/bloc/wishlist/wishlist_bloc.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/data/response/status.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/shimmers/all_product_shimmer.dart';
import 'package:my_app/utils/utils.dart';
import 'package:my_app/view/home/widget/product_tile.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const GetAllProducts("All"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: context.localizations!.add_to_cart,
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        buildWhen: (previous, current) =>
            previous.postApiStatus != current.postApiStatus,
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state.postApiStatus == PostApiStatus.loading,
            progressIndicator: SpinKitCircle(
              size: 20.w,
              color: AppColors.buttonColor,
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: BlocBuilder<ProductBloc, ProductState>(
                  buildWhen: (previous, current) =>
                      previous.allProrducts != current.allProrducts,
                  builder: (context, state) {
                    switch (state.allProrducts.status) {
                      case Status.loading:
                        return const AllProductShimmer(
                          count: 10,
                        );
                      case Status.complete:
                        final displayedItem = state.allProrducts.data!.data;
                        final columns = Utils.isTablet(context)
                            ? 3
                            : Utils.isMobile(context)
                                ? 2
                                : 1;
                        final rows = (displayedItem!.length / columns).ceil();
                        return displayedItem.isEmpty
                            ?  Center(
                                child: Text(context.localizations!.noProductFound),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 22.0),
                                child: LayoutGrid(
                                  columnSizes: List.generate(
                                    columns,
                                    (_) => 1.fr,
                                  ),
                                  rowSizes: List.generate(rows, (_) => auto),
                                  rowGap: 40, // equivalent to mainAxisSpacing
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
                        default:return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
