import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/bloc/restaurant/rastaurant_state.dart';
import 'package:my_app/bloc/restaurant/restaurant_bloc.dart';
import 'package:my_app/bloc/restaurant/restaurant_event.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/data/response/status.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/shimmers/all_brands_shimmer.dart';

class AllRestaurantScreen extends StatefulWidget {
  const AllRestaurantScreen({super.key});

  @override
  State<AllRestaurantScreen> createState() => _AllRestaurantScreenState();
}

class _AllRestaurantScreenState extends State<AllRestaurantScreen> {
  final TextEditingController _restaurantSearchController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<RestaurantBloc>().add(GetAllRestaurantWithQuery(""));
    _restaurantSearchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _restaurantSearchController.text.trim();
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call stopTyping() after that.
    Timer(duration, () => stopTyping(query));
    setState(() {});
  }

  stopTyping(String query) {
    context.read<RestaurantBloc>().add(GetAllRestaurantWithQuery(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 2),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFormField(
                controller: _restaurantSearchController,
                cursorColor: Colors.grey,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: const Color(0xff7A869A)),
                decoration: InputDecoration(
                  suffixIcon: _restaurantSearchController.text.isEmpty
                      ? const Icon(Icons.search, color: Colors.grey)
                      : GestureDetector(
                          onTap: () {
                            _restaurantSearchController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.close, color: Colors.grey)),
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: const Color(0xff7A869A)),
                  isDense: false,
                  filled: true,
                  fillColor: const Color(0xffF4F5F7),
                  prefixIcon: const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.location_on_rounded,
                      color: Color(0xffC1C7D0),
                    ),
                  ),
                  hintText: context.localizations!.search,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            switch (state.getAllRestaurantWithQuery.status) {
              case Status.loading:
                return const AllBrandsShimmer();
              case Status.complete:
                return state.getAllRestaurantWithQuery.data!.isEmpty
                    ? const SizedBox()
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            Padding(padding: EdgeInsets.only(bottom: 10.h)),
                        itemBuilder: (context, index) {
                          return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: Image.network(
                                          state.getAllRestaurantWithQuery
                                              .data![index].image!,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                state.getAllRestaurantWithQuery
                                                    .data![index].title!,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp,
                                                  color:
                                                      const Color(0xff172B4D),
                                                ),
                                                maxLines: 1,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Flexible(
                                                child: SvgPicture.asset(
                                                    ImageString.verified),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Text(
                                            "8700 Beverly, CA 90048",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                                color: const Color(0xff7A869A)),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Text(
                                            "2 items",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                                color: const Color(0xff7A869A)),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: context.height * 0.02,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xffEF9F27),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                            RouteName.brandDetailsScreen,
                                            arguments: state
                                                .getAllRestaurantWithQuery
                                                .data![index]
                                                .sId);
                                      },
                                      child: Text(
                                        context.localizations!.visit,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ));
                        },
                        itemCount: state.getAllRestaurantWithQuery.data!.length,
                      );
              case Status.error:
                return Center(
                  child: Text(
                    state.getAllRestaurantWithQuery.message.toString(),
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
        ),
      ),
    );
  }
}
