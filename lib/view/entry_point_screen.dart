import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/cart/cart_bloc.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/view/cart/cart_screen.dart';
import 'package:my_app/view/favourite/fovourite_screen.dart';
import 'package:my_app/view/home/home_screen.dart';
import 'package:my_app/view/profile/profile_screen.dart';
import 'package:badges/badges.dart' as badges;

class EntryPointScreen extends StatefulWidget {
  const EntryPointScreen({super.key});

  @override
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen> {
  int currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
    // const TrackingOrder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: const Color(0xffF4F5F7),
      body: pages[currentIndex],
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.redColor,
      //   shape: const CircleBorder(),
      //   elevation: 4.0,
      //   onPressed: () {
      //     setState(() {
      //       currentIndex = 4;
      //     });
      //   },
      //   child: IconButton(
      //       onPressed: null, icon: SvgPicture.asset(ImageString.plus)),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BlocBuilder<CartBloc, CartItemState>(
        builder: (context, state) {
          return BottomNavigationBar(
            
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.redColor,
            unselectedItemColor: Colors.grey.withOpacity(0.8),
            items:  [
              const BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Home"),
             
              BottomNavigationBarItem(
                  icon: badges.Badge(
                    badgeContent: Text(state.cartItem.length.toString()),
                    child: const Icon(Icons.shopping_bag),
                  ),
                  label: "Cart"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favorite"),
                   const BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          );
        },
      ),
    );
  }
}
// BottomAppBar(
//         shadowColor: Colors.black,
//         elevation: 100.0,
//         notchMargin: 8.0,
//         shape: const CircularNotchedRectangle(),
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         height: 60,
//         color: Colors.white,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               icon: SvgPicture.asset(ImageString.home),
//               onPressed: () {
//                 setState(() {
//                   currentIndex = 0;
//                 });
//               },
//             ),
//             IconButton(
//               icon: SvgPicture.asset(ImageString.user1),
//               onPressed: () {
//                 setState(() {
//                   currentIndex = 1;
//                 });
//               },
//             ),
//             IconButton(
//               icon: SvgPicture.asset(ImageString.comment),
//               onPressed: () {
//                 setState(() {
//                   currentIndex = 2;
//                 });
//               },
//             ),
//             IconButton(
//               icon: SvgPicture.asset(ImageString.heart),
//               onPressed: () {
//                 setState(() {
//                   currentIndex = 3;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),