import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/view/chat/chat_screen.dart';
import 'package:my_app/view/home/home_screen.dart';
import 'package:my_app/view/profile/profile_screen.dart';

class EntryPointScreen extends StatefulWidget {
  const EntryPointScreen({super.key});

  @override
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen> {
  int currentIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    ProfileScreen(),
    ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xffF4F5F7),
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.redColor,
        shape: CircleBorder(),
        elevation: 4.0,
        onPressed: () {},
        child: IconButton(
            onPressed: null, icon: SvgPicture.asset(ImageString.plus)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shadowColor: Colors.black,
        elevation:100.0,
        shape: const CircularNotchedRectangle(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(ImageString.home),
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: SvgPicture.asset(ImageString.user1),
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
            ),
            IconButton(
              icon: SvgPicture.asset(ImageString.comment),
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                });
              },
            ),
            IconButton(
              icon: SvgPicture.asset(ImageString.heart),
              onPressed: () {
                // setState(() {
                //   currentIndex = 3;
                // });
              },
            ),
          ],
        ),
      ),
    );
  }
}
