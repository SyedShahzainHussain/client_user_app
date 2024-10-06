import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/bloc/products/product_bloc.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/data/response/status.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/shimmers/all_product_shimmer.dart';
import 'package:my_app/utils/utils.dart';
import 'package:my_app/view/home/widget/product_tile.dart';

import '../../bloc/wishlist/wishlist_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const SearchProductAccordingToTitle(""));
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call stopTyping() after that.
    Timer(duration, () => stopTyping(query));
    setState(() {});
  }

  stopTyping(String query) {
    context.read<ProductBloc>().add(SearchProductAccordingToTitle(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.buttonColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50.h,
              child: TextFormField(
                controller: _searchController,
                textInputAction: TextInputAction.done,
                autofocus: true,
                cursorColor: AppColors.buttonColor,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  suffixIcon: _searchController.text.isEmpty
                      ? const Icon(Icons.search, color: Colors.grey)
                      : GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.close, color: Colors.grey)),
                  hintText: context.localizations!.search_product,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                  isDense: true,
                  filled: true,
                  fillColor: AppColors.darkGrey.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18.sp,
          ),
        ),
        title: Text(
          context.localizations!.search_products,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state.postApiStatus == PostApiStatus.loading,
            progressIndicator: SpinKitCircle(
              size: 20.w,
              color: AppColors.buttonColor,
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    buildWhen: (previous, current) =>
                        previous.searchProrducts != current.searchProrducts,
                    builder: (context, state) {
                      // Show loading only when searching
                      if (state.searchProrducts.status == Status.loading) {
                        return const AllProductShimmer();
                      }

                      if (state.searchProrducts.status == Status.complete &&
                          (state.searchProrducts.data?.data!.isEmpty ?? true)) {
                        return Column(
                          children: [
                            SizedBox(height: context.height * .3),
                            Center(
                              child: Text(
                                "${context.localizations!.noProductFound}!",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      }

                      switch (state.searchProrducts.status) {
                        case Status.complete:
                          final displayedItem =
                              state.searchProrducts.data!.data;
                          final columns = Utils.isTablet(context)
                              ? 3
                              : Utils.isMobile(context)
                                  ? 2
                                  : 1;
                          final rows = (displayedItem!.length / columns).ceil();
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 22.0),
                            child: LayoutGrid(
                              columnSizes: List.generate(columns, (_) => 1.fr),
                              rowSizes: List.generate(rows, (_) => auto),
                              rowGap: 40,
                              columnGap: 24,
                              children: [
                                for (var product in displayedItem)
                                  ProductTile(productModel: product),
                              ],
                            ),
                          );
                        case Status.error:
                          return Column(
                            children: [
                              SizedBox(height: context.height * .3),
                              Center(
                                child: Text(
                                  state.searchProrducts.message.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        default:
                          return Column(
                            children: [
                              SizedBox(height: context.height * .3),
                              Center(
                                child: Text(
                                  "${context.localizations!.noProductFound}!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
