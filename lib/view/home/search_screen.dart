import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/bloc/products/product_bloc.dart';
import 'package:my_app/bloc/products/product_bloc.dart';
import 'package:my_app/bloc/products/product_bloc.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/data/response/status.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/shimmers/all_product_shimmer.dart';
import 'package:my_app/utils/utils.dart';
import 'package:my_app/view/home/widget/product_tile.dart';

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
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        isSearching = true; // Start showing loading indicator
      });
      context.read<ProductBloc>().add(SearchProductAccordingToTitle(query));
    } else {
      // Clear results if the search query is empty
      setState(() {
        isSearching = false; // Hide loading indicator
      });
      context.read<ProductBloc>().add(SearchProductAccordingToTitle(query));
    }
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
                cursorColor: AppColors.buttonColor,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  suffixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Search Product",
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
          "Search Products",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: BlocBuilder<ProductBloc, ProductState>(
              buildWhen: (previous, current) =>
                  previous.searchProrducts != current.searchProrducts,
              builder: (context, state) {
                // Show loading only when searching
                if (state.searchProrducts.status == Status.loading &&
                    isSearching == true) {
                  return const AllProductShimmer();
                }

                if (state.searchProrducts.status == Status.complete &&
                    (state.searchProrducts.data?.data!.isEmpty ?? true)) {
                  return Column(
                    children: [
                      SizedBox(height: context.height * .3),
                      Center(
                        child: Text(
                          "No Product Found!",
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
                    final displayedItem = state.searchProrducts.data!.data;
                    final columns = Utils.isTablet(context)
                        ? 3
                        : Utils.isMobile(context)
                            ? 2
                            : 1;
                    final rows = (displayedItem!.length / columns).ceil();
                    return Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 22.0),
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
                            "No Product Found!",
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
  }
}
