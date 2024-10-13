import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/utils/utils.dart';

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
  final _form = GlobalKey<FormState>();
  late String initialName;
  late String initialAddress;
  String profilePic =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png";

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfileData());
  }

  void updateProfile() {
    final validate = _form.currentState!.validate();
    if (!validate) return;
    if (nameController.text.trim() != initialName.trim() ||
        addressController.text.trim() != initialAddress.trim() ||
        context.read<ProfileBloc>().state.image != null) {
      final additionalData = {
        "name": nameController.text,
        "address": addressController.text,
      };

      context.read<ProfileBloc>().add(UpdateProfile(additionalData, context));
    } else {
      Utils.showToast("No changes detected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        nameController.text = state.name;
        addressController.text = state.address;
        emailController.text = state.email;
        initialName = state.name;
        initialAddress = state.address;
        if (state.profilePic.isNotEmpty) {
          profilePic = state.profilePic;
        }

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
                    context.read<ProfileBloc>().add(ClearPickImageEvent());
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.secondaryTextColor,
                    size: 18.sp,
                  )),
            ),
            body: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, _) {
                if (!didPop) {
                  context.read<ProfileBloc>().add(ClearPickImageEvent());
                  Navigator.pop(context);
                }
              },
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        buildWhen: (previous, current) =>
                            previous.image != current.image!,
                        builder: (context, state) {
                          return Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.redColor,
                                        width: 2.0,
                                      )),
                                  child: CircleAvatar(
                                    backgroundImage: (state.image == null ||
                                            state.image!.path == "")
                                        ? NetworkImage(profilePic)
                                        : FileImage(File(state.image!.path)),
                                    radius: 60,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: -5,
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.redColor,
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        context
                                            .read<ProfileBloc>()
                                            .add(PickImageEvent(context));
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
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
                            TextFormField(
                              validator: (value) {
                                return null;
                              },
                              controller: nameController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: context.localizations!.name,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(),
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
                            TextFormField(
                              enabled: false,
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
                                  disabledBorder: const OutlineInputBorder(),
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
                            TextFormField(
                              validator: (value) {
                                return null;
                              },
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
                            BlocListener<ProfileBloc, ProfileState>(
                              listenWhen: (previous, current) =>
                                  previous.message != current.message,
                              listener: (context, state) {
                                if (state.message.isNotEmpty) {
                                  Utils.showToast(state.message);
                                }
                              },
                              child: BlocBuilder<ProfileBloc, ProfileState>(
                                buildWhen: (previous, current) =>
                                    previous.postApiStatus !=
                                    current.postApiStatus,
                                builder: (context, state) {
                                  return Button(
                                    showRadius: true,
                                    loading: state.postApiStatus ==
                                        PostApiStatus.loading,
                                    onTap: () {
                                      updateProfile();
                                    },
                                    title:
                                        context.localizations!.update_profile,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
