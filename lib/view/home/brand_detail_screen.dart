// import 'package:flutter/material.dart';
// import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';

// class BrandDetailScreen extends StatefulWidget {
//   const BrandDetailScreen({super.key});

//   @override
//   State<BrandDetailScreen> createState() => _BrandDetailScreenState();
// }

// class _BrandDetailScreenState extends State<BrandDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return [
//               SliverAppBar(
//                 backgroundColor: Colors.white,
//                 expandedHeight: 200.0,
//                 floating: false,
//                 pinned: true,
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Image.network(
//                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSf9fG0XSXlw5HHtdVIhc1_gl4vzcKeCOAkoBD07BHiTAyvsVoKqvRbLkwuNSTheOd3Kk4&usqp=CAU',
//                     fit:
//                         BoxFit.cover, // Ensure the image covers the entire area
//                   ),
//                 ),
//               ),
//             ];
//           },
//       ),
//     );
//   }

// }
