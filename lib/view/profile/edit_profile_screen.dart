import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/auth/profile/profile_bloc.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  final String image;
  final String title;
  final String address;
  const EditProfileScreen({
    super.key,
    required this.title,
    required this.image,
    required this.address,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final _form = GlobalKey<FormState>();
  late String initialName;
  late String initialAddress;
  @override
  void initState() {
    super.initState();
    initialName = widget.title;
    initialAddress = widget.address;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      nameController.text = widget.title;
      addressController.text = widget.address;
    });
  }

  void updateProfile() {
    final validate = _form.currentState!.validate();
    if (!validate) return;
    if (validate &&
        (nameController.text != initialName ||
            addressController.text != initialAddress ||
            context.read<ProfileBloc>().state.image != null)) {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Edit Profile",
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) => previous.message != current.message,
        listener: (context, state) {
          if (state.message.isNotEmpty) {
            Utils.showToast(state.message);
          }
        },
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop,_) {
            if (!didPop) {
              context.read<ProfileBloc>().add(ClearPickImageEvent());
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  // Todo Profile Picture
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
                                backgroundImage: (state.image == null||state.image!.path=="")
                                    ? NetworkImage(widget.image)
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

                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      textEditingController: nameController,
                      hintText: context.localizations!.name,
                      validator: (value) {
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      textEditingController: addressController,
                      hintText: "Address",
                      validator: (value) {
                        return null;
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.postApiStatus != current.postApiStatus,
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(12.0),
            child: Button(
              loading: state.postApiStatus == PostApiStatus.loading,
              onTap: () {
                updateProfile();
              },
              title: "Update Profile",
            ),
          );
        },
      ),
    );
  }
}
