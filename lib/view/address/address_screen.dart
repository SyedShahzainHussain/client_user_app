import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/model/address_model.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AddressModel> address = [
      AddressModel(
          id: DateTime.now().toIso8601String(),
          address: "CIA",
          city: "Karachi"),
      AddressModel(
          id: DateTime.now().toIso8601String(),
          address: "CIA",
          city: "Karachi",
          noteToRider: "Wlaa Bloc Near Karchi"),
    ];

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
        body: ListView.separated(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address[index].address,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        address[index].city,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: const Color.fromARGB(255, 14, 13, 13),
                              fontWeight: FontWeight.w500,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Note to rider : ${address[index].noteToRider ?? "none"}",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: const Color.fromARGB(255, 14, 13, 13),
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.newAddressScreenName,
                              arguments: {
                                "address": address[index].address,
                                "latitude": 24.8916,
                                "longitude": 67.0681
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
                      const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.grey,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
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
            title: "Add New Address",
            onTap: () {
              Navigator.pushNamed(context, RouteName.newAddressScreenName,
                  arguments: {"address": "", "latitude": 0.0, "longitude": 0.0});
            },
            showRadius: true,
          ),
        ),
      ),
    );
  }
}
