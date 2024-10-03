import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/config/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPassword = TextEditingController();
  final password = TextEditingController();
  final confirmNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Change Password",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.secondaryTextColor,
                size: 18.sp,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Password",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: currentPassword,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Current Password",
                        hintStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "New Password",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: password,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "New Password",
                          hintStyle:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                          isDense: true),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Confirm New Password",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: confirmNewPassword,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Confirm New Password",
                          hintStyle:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                          isDense: true),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Button(
                      showRadius: true,
                      title: "Change Password",
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
