import 'package:flutter/material.dart';
import 'package:my_app/view/home/widget/product_tile.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

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
      // body: Padding(
      //   padding: const EdgeInsets.only(left: 12.0, right: 22.0,bottom: kBottomNavigationBarHeight),
      //   child: GridView.builder(
      //       itemCount: 10,
      //       shrinkWrap: true,
      //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //         childAspectRatio: 0.85,
      //         mainAxisSpacing: 10,
      //         crossAxisSpacing: 20,
      //       ),
      //       itemBuilder: (context, index) {
      //         return ProductTile();
      //       }),
      // ),
    );
  }
}
