import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/custom_appbar.dart';

class ChangeLanguageScreen extends StatelessWidget {
  ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Language",
        ),
        persistentFooterButtons: [
          Button(
            showRadius: true,
            title: "Change Language",
            onTap: () {},
          )
        ],
        body: ListView(
          children: countryList.map((data) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffC1C7D0),
                      ),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: ListTile(
                    leading: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: data["flag"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(data["title"]),
                  )),
            );
          }).toList(),
        ),
      ),
    );
  }

  final List countryList = [
    {
      "title": "English (US)",
      "flag": "https://flagcdn.com/w320/um.png",
    },
    {
      "title": "Arabic (AR)",
      "flag": "https://flagcdn.com/w320/sa.png",
    },
  ];
}
