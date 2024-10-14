import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/bloc/address/address_bloc.dart';
import 'package:my_app/bloc/address/address_event.dart';
import 'package:my_app/bloc/address/address_state.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/utils/utils.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(GetAddress());
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        elevation: 10.0,
      )),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Addresses",
        ),
        body: RefreshIndicator(
          color: AppColors.buttonColor,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            context.read<AddressBloc>().add(GetAddress());
          },
          child: BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              switch (state.postApiStatus) {
                case PostApiStatus.loading:
                  return Utils.showLoading(color: AppColors.buttonColor);
                case PostApiStatus.success:
                  final address = state.addressList;
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                    ),
                    itemCount: address.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    address[index].address.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
                                          color: const Color.fromARGB(
                                              255, 14, 13, 13),
                                          fontWeight: FontWeight.w500,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                                  //         color: const Color.fromARGB(255, 14, 13, 13),
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
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.newAddressScreenName,
                                        arguments: {
                                          "address": address[index].address,
                                          "latitude": address[index].latitude,
                                          "longitude": address[index].longitude
                                        });
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<AddressBloc>().add(
                                        DeleteAddress(id: address[index].sId!));
                                    context
                                        .read<AddressBloc>()
                                        .add(GetAddress());
                                  },
                                  child: const Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                case PostApiStatus.error:
                  return Center(
                    child: Text(
                      state.message.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black),
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
        bottomSheet: Container(
          margin: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Button(
            title: context.localizations!.add_New_Address,
            onTap: () {
              Navigator.pushNamed(context, RouteName.newAddressScreenName,
                  arguments: {
                    "address": "",
                    "latitude": 0.0,
                    "longitude": 0.0
                  });
            },
            showRadius: true,
          ),
        ),
      ),
    );
  }
}
