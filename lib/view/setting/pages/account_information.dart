import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/extension/localization_extension.dart';

import '../../../bloc/auth/profile/profile_bloc.dart';
import '../../../common/button.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfileData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        nameController.text = state.name;
        addressController.text = state.address;
        emailController.text = state.email;
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.0,
              scrolledUnderElevation: 0.0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                context.localizations!.account_information,
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
            body: Column(
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
                        context.localizations!.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextField(
                        controller: nameController,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: context.localizations!.name,
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
                        context.localizations!.email,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextField(
                        controller: emailController,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: context.localizations!.email,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(),
                            isDense: true),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        context.localizations!.address,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextField(
                        controller: addressController,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: context.localizations!.address,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(),
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
                        title: context.localizations!.update_profile,
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
