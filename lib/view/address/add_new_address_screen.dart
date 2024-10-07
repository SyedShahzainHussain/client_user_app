import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/extension/media_query_extension.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  late GoogleMapController googleMapController;
  MapType mapType = MapType.normal;
  final TextEditingController _controller = TextEditingController();

  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  double _sheetPosition = 0.30;
  bool isAtMaxSize = false;
  String _sessionToken = '1234567890';

  @override
  void initState() {
    super.initState();
    sheetController.addListener(() {
      setState(() {
        // Check if the sheet has reached its maximum size
        if (sheetController.size == 1.0) {
          isAtMaxSize = sheetController.size == 1.0;
        } else {
          if (sheetController.size == 0.40 || sheetController.size == 0.30) {
            isAtMaxSize = false;
          }
        }
      });
    });
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken.isEmpty) {
      setState(() {
        _sessionToken = (Random(12222322).toString());
      });
    }
    getSuggestion(_controller.text);
  }

  getSuggestion(String input) async {
    String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        '$baseUrl?input=$input&key=AIzaSyAoSbver7G9emTgsZMM4RCAXt3z5pjauYE&sessionToken=$_sessionToken';
        
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    sheetController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              mapType: mapType,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(24.8607, 67.0011),
                zoom: 14.4746,
              )),
          DraggableScrollableSheet(
            initialChildSize: _sheetPosition,
            minChildSize: 0.30,
            controller: sheetController,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: SizedBox(
                  height: context.height,
                  child: Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      Positioned(
                        top: -kToolbarHeight + kToolbarHeight,
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            if (mapType == MapType.normal) {
                              setState(() {
                                mapType = MapType.satellite;
                              });
                            } else {
                              setState(() {
                                mapType = MapType.normal;
                              });
                            }
                          },
                          child: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: Colors.white, width: 1.0)),
                              margin: const EdgeInsets.only(left: 10),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    mapType == MapType.normal
                                        ? ImageString.satelliteImage
                                        : ImageString.standardImage,
                                    fit: BoxFit.cover,
                                  ))),
                        ),
                      ),
                      Positioned(
                        top: -kToolbarHeight + kToolbarHeight,
                        right: 0,
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          mini: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          onPressed: () async {
                            Position position = await currentPosition();
                            googleMapController.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 14.4746,
                            )));
                          },
                          child: const Icon(
                            Icons.my_location,
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                            top: kToolbarHeight,
                          ),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            boxShadow: [],
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  height: 4,
                                  width: 40,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              isAtMaxSize
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _sheetPosition = 0.30;
                                                    isAtMaxSize = false;
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  size: 20.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 40,
                                                  child: TextFormField(
                                                    maxLines: 1,
                                                    autofocus: true,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge!
                                                        .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.grey
                                                          .withOpacity(0.3),
                                                      filled: true,
                                                      suffixIcon: const Icon(
                                                        Icons.close,
                                                        size: 20,
                                                        color:
                                                            Color(0xff83829A),
                                                      ),
                                                      isDense: true,
                                                      isCollapsed: true,
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                        left: 8,
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(9),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Color(
                                                                      0xff83829A),
                                                                  width: 0.4)),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(9),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Color(
                                                                      0xff83829A),
                                                                  width: 0.4)),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(9),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Color(
                                                                      0xff83829A),
                                                                  width: 0.4)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey.withOpacity(0.4),
                                        )
                                      ],
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "asdadkadkasdjkajdaskdjkasjdaksdjkasdjaakdnasdjadjasdjahsjdajdashdhjshajdhjshahjdshasjhdhsj",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.sp),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  "Karachi",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          color: Colors.grey),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.edit_outlined,
                                              color: Colors.black,
                                            ),
                                            iconSize: 20.0,
                                          )
                                        ],
                                      ),
                                    ),
                            ],
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 10,
            left: 10,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Material(
                  borderRadius: BorderRadius.circular(100.0),
                  elevation: 5.0,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          isAtMaxSize
              ? const SizedBox()
              : Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0))),
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          child: Button(
                            showRadius: true,
                            title: "Add address details",
                            onTap: () {},
                          )),
                    ),
                  ))
        ],
      ),
    );
  }

// Function to determine the user's current position
  Future<Position> currentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Checking if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    // Checking the location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Requesting permission if it is denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    // Handling the case where permission is permanently denied
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    // Getting the current position of the user
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
