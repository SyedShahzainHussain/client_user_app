import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_app/bloc/address/address_bloc.dart';
import 'package:my_app/bloc/address/address_event.dart';
import 'package:my_app/bloc/address/address_state.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/t_section_heading.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';

class Utils {
  final ImagePicker _picker = ImagePicker();
  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // Position at bottom
      backgroundColor: Colors.black45,
      textColor: Colors.white,
    );
  }

  static showLoading({Color? color}) {
    return SpinKitCircle(
      size: 20.w,
      color: color ?? Colors.white,
    );
  }

  static bool isExtraSmallMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 350;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 500 &&
      MediaQuery.of(context).size.width > 350;

  static bool isMobileLarge(BuildContext context) =>
      MediaQuery.of(context).size.width <= 700 &&
      MediaQuery.of(context).size.width >= 500;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 700 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<XFile?> pickImage(ImageSource imageSource) async {
    final image = await _picker.pickImage(source: imageSource);
    if (image != null) {
      return image;
    }
    return null;
  }

  Future<XFile?> showBottomSheetDialog(BuildContext context) async {
    return await showModalBottomSheet<XFile?>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              final image = await pickImage(ImageSource.camera);
                              Navigator.pop(context, image);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              final image =
                                  await pickImage(ImageSource.gallery);
                              Navigator.pop(context, image);
                            },
                            icon: const Icon(
                                Icons.photo_size_select_actual_outlined),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future showAddressDialog(BuildContext context) async {
    await showModalBottomSheet(
        showDragHandle: true,
        backgroundColor: Colors.white,
        context: context,
        constraints: BoxConstraints(maxHeight: 500.h),
        builder: (_) => Container(
              padding: const EdgeInsets.all(12.0),
              child: BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  final address = state.addressList;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                        title: context.localizations!.select_Address,
                        showActionButton: false,
                        textColor: Colors.black,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      address.isEmpty
                          ? Center(
                              child: Text(
                                "No Address Found",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                            )
                          : SizedBox(
                              height: 300.h,
                              child: ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  color: Colors.grey,
                                ),
                                itemCount: address.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Dispatch the select address event when an address is tapped
                                      context
                                          .read<AddressBloc>()
                                          .add(SelectAddress(address[index]));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.grey,
                                            size: 22.0,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  address[index]
                                                      .address
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  "Karachi",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge!
                                                      .copyWith(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 14, 13, 13),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                // SizedBox(
                                                //   height: 5.h,
                                                // ),
                                                // Text(
                                                //   "Note to rider : ${address[index].noteToRider ?? "none"}",
                                                //   style: Theme.of(context)
                                                //       .textTheme
                                                //       .labelLarge!
                                                //       .copyWith(
                                                //         color: const Color.fromARGB(
                                                //             255, 14, 13, 13),
                                                //       ),
                                                //   maxLines: 1,
                                                //   overflow: TextOverflow.ellipsis,
                                                // ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Radio(
                                              value: address[index],
                                              groupValue: state.selectedAddress,
                                              onChanged: (value) {
                                                // Dispatch the select address event when the radio is changed
                                                context
                                                    .read<AddressBloc>()
                                                    .add(SelectAddress(value!));
                                              })
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                      const Spacer(),
                      Button(
                          showRadius: true,
                          title: context.localizations!.add_New_Address,
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.newAddressScreenName,
                                arguments: {
                                  "address": "",
                                  "latitude": 0.0,
                                  "longitude": 0.0
                                });
                          })
                    ],
                  );
                },
              ),
            ));
  }

  String formatDate(String dateString) {
    try {
      // Parse the date string into a DateTime object
      DateTime date = DateTime.parse(dateString);

      // Format the DateTime object into a desired string format
      String formattedDate = DateFormat('dd MMM yyyy').format(date);

      return formattedDate;
    } catch (e) {
      print('Error formatting date: $e');
      return 'Invalid date';
    }
  }
}
