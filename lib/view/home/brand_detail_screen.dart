import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/restaurant/rastaurant_state.dart';
import 'package:my_app/bloc/restaurant/restaurant_bloc.dart';
import 'package:my_app/bloc/restaurant/restaurant_event.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/data/response/status.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/model/restaurant_details_model.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';

class BrandDetailScreen extends StatefulWidget {
  final String id;
  const BrandDetailScreen({super.key, required this.id});

  @override
  State<BrandDetailScreen> createState() => _BrandDetailScreenState();
}

// Data mapProductToData(Products product) {
//   return Data(
//     sId: product.sId,
//     title: product.title,
//     slug: product.slug,
//     description: product.description,
//     price: product.price,
//     category: product.category,
//     address: product.address,
//     quantity: product.quantity,
//     images: product.images,
//     totalrating: product.totalrating,
//     createdAt: product.createdAt,
//     updatedAt: product.updatedAt,
//     iV: product.iV,
//     ratings: product.ratings
//         ?.map((rating) => Rating(
//               sId: rating,
//               comment: rating.comment,
//               star: rating.star,
//               createdAt: rating.,
//               updatedAt: rating.updatedAt,
//             ))
//         .toList(),
//     // If the product has toppings or other fields, map them accordingly
//   );
// }

class _BrandDetailScreenState extends State<BrandDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<RestaurantBloc>()
        .add(RestaurantDetails(id: "671638b6f1347bd72246ce0a"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          switch (state.restaurantDetailsList.status) {
            case Status.loading:
              return const CircularProgressIndicator();
            case Status.error:
              return const Center(
                child: Text("Error Occured"),
              );
            case Status.complete:
              final categoryList = state.restaurantCategoryList.data ?? [];
              final productList = state.restaurantDetailsList.data!;

              // Create a map of categories to their corresponding products
              Map<String, List<Products>> categoryProductMap = {};

              for (var category in categoryList) {
                categoryProductMap[category.title!] = productList.products!
                    .where((product) => product.category == category.title)
                    .toList();
              }
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    expandedHeight: 200,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.black,
                              size: 16,
                            )),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: CachedNetworkImage(
                        imageUrl: productList.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productList.title!,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.black,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Free",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    "Delivery",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: PrimaryScrollController(
                      controller: PrimaryScrollController.of(context),
                      child: ScrollableListTabScroller(
                        itemCount: categoryProductMap.length,
                        tabBuilder:
                            (BuildContext context, int index, bool active) =>
                                Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            categoryProductMap.keys.elementAt(index),
                            style: !active
                                ? null
                                : const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                          ),
                        ),
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categoryProductMap.keys.elementAt(index),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                              ...categoryProductMap.values
                                  .elementAt(index)
                                  .asMap()
                                  .map(
                                    (index, value) => MapEntry(
                                      index,
                                      ListTile(
                                        onTap: () {
                                          // final data = Data();
                                          // Navigator.pushNamed(context,
                                          //     RouteName.detailScreenName,
                                          //     arguments: {
                                          //       "data": value.address
                                          //     });
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        leading: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: CachedNetworkImage(
                                            imageUrl: value.images![0],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.title!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Text(
                                              value.description!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .values
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
