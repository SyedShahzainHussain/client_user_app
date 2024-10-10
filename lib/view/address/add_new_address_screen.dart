import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/bloc/google_place_api/google_place_api_bloc.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/media_query_extension.dart';

class AddNewAddressScreen extends StatefulWidget {
  final String address;
  final double latitude;
  final double longitude;

  const AddNewAddressScreen(
      {super.key,
      required this.address,
      required this.latitude,
      required this.longitude});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  late GoogleMapController googleMapController;
  MapType mapType = MapType.normal;
  final TextEditingController _controller = TextEditingController();

  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  final double _sheetPosition = 0.30;
  bool isAtMaxSize = false;
  bool showMapIcon = true; // New bool for map icon visibility

  @override
  void initState() {
    super.initState();

    if (widget.address.isEmpty ||
        widget.latitude == 0.0 ||
        widget.longitude == 0.0) {
      context
          .read<GooglePlaceApiBloc>()
          .add(GetCurrentPosition(context: context));
    } else {
      context
          .read<GooglePlaceApiBloc>()
          .add(GetTheEditAddress(address: widget.address));
    }
    showMapIcon = false;

    sheetController.addListener(() {
      setState(() {
        // Hide map icon when user scrolls up beyond initial size
        if (sheetController.size > 0.50) {
          showMapIcon = true;
        } else {
          // Show map icon when sheet is at the initial size (0.30)
          showMapIcon = false;
        }
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
    context.read<GooglePlaceApiBloc>().add(CreateSessionTokenEveryTime());
    getSuggestion(_controller.text);
  }

  getSuggestion(String input) async {
    context.read<GooglePlaceApiBloc>().add(FetchGooglePlaceApi(input: input));
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    sheetController.removeListener(() {});
    super.dispose();
  }

  Timer? debounceTimer;
  void _onCameraMove(CameraPosition position) {
    print("Moving");
    // Cancel the previous timer to avoid multiple timer instances
    debounceTimer?.cancel();

    // Start a new timer for 1 second to wait for the user to stop moving the camera
    debounceTimer = Timer(const Duration(seconds: 1), () {
      // Fetch the address for the selected location

      context.read<GooglePlaceApiBloc>().add(GetAddressFromLatLng(
          longitude: position.target.longitude,
          latitude: position.target.latitude));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (isAtMaxSize) {
            // Animate the sheet to maximum size (1.0)
            sheetController.animateTo(
              0.30, // Maximum size
              duration:
                  const Duration(milliseconds: 300), // Duration of animation
              curve: Curves.easeInOut, // Animation curve
            );
          } else {
            if (!didPop) {
              Navigator.pop(context);
            }
          }
        },
        child: Stack(
          children: [
            // Todo Google Map
            BlocBuilder<GooglePlaceApiBloc, GooglePlaceApiState>(
              builder: (context, state) {
                return GoogleMap(
                  onCameraMove: _onCameraMove,
                  mapType: mapType,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController = controller;
                    if (widget.address.isEmpty ||
                        widget.latitude == 0.0 ||
                        widget.longitude == 0.0) {
                      googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(state.position!.latitude,
                                state.position!.longitude),
                            zoom: 14.4746,
                          ),
                        ),
                      );
                    } else {
                      googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(widget.latitude, widget.longitude),
                            zoom: 14.4746,
                          ),
                        ),
                      );
                    }
                  },
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 15,
                  ),
                );
              },
            ),
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
                        BlocBuilder<GooglePlaceApiBloc, GooglePlaceApiState>(
                          builder: (context, state) {
                            return Positioned(
                              top: -kToolbarHeight + kToolbarHeight,
                              right: 0,
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                mini: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                onPressed: () async {
                                  context.read<GooglePlaceApiBloc>().add(
                                      GetCurrentPosition(context: context));
                                  googleMapController.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                    target: LatLng(state.position!.latitude,
                                        state.position!.longitude),
                                    zoom: 14.4746,
                                  )));
                                },
                                child: const Icon(
                                  Icons.my_location,
                                  color: AppColors.buttonColor,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Animate the sheet to maximum size (1.0)
                            sheetController.animateTo(
                              1.0, // Maximum size
                              duration: const Duration(
                                  milliseconds: 300), // Duration of animation
                              curve: Curves.easeInOut, // Animation curve
                            );
                          },
                          child: Container(
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      height: 4,
                                      width: 40,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  isAtMaxSize
                                      ? BlocBuilder<GooglePlaceApiBloc,
                                          GooglePlaceApiState>(
                                          builder: (context, state) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.w),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Animate the sheet to maximum size (1.0)
                                                          sheetController
                                                              .animateTo(
                                                            0.30, // Maximum size
                                                            duration: const Duration(
                                                                milliseconds:
                                                                    300), // Duration of animation
                                                            curve: Curves
                                                                .easeInOut, // Animation curve
                                                          );
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
                                                            controller:
                                                                _controller,
                                                            maxLines: 1,
                                                            autofocus: true,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge!
                                                                .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                            textAlignVertical:
                                                                TextAlignVertical
                                                                    .center,
                                                            decoration:
                                                                InputDecoration(
                                                              fillColor: Colors
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.3),
                                                              filled: true,
                                                              suffixIcon:
                                                                  const Icon(
                                                                Icons.close,
                                                                size: 20,
                                                                color: Color(
                                                                    0xff83829A),
                                                              ),
                                                              isDense: true,
                                                              isCollapsed: true,
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 8,
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              9),
                                                                  borderSide: const BorderSide(
                                                                      color: Color(
                                                                          0xff83829A),
                                                                      width:
                                                                          0.4)),
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              9),
                                                                  borderSide: const BorderSide(
                                                                      color: Color(
                                                                          0xff83829A),
                                                                      width:
                                                                          0.4)),
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              9),
                                                                  borderSide: const BorderSide(
                                                                      color: Color(
                                                                          0xff83829A),
                                                                      width:
                                                                          0.4)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                ),
                                                BlocBuilder<GooglePlaceApiBloc,
                                                        GooglePlaceApiState>(
                                                    builder: (context, state) {
                                                  switch (state.postApiStatus) {
                                                    case PostApiStatus.loading:
                                                      return const SizedBox();
                                                    case PostApiStatus.success:
                                                      return ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: state
                                                            .predictions!
                                                            .predictions!
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return GestureDetector(
                                                            onTap: () async {},
                                                            child: ListTile(
                                                              title: Text(
                                                                state
                                                                    .predictions!
                                                                    .predictions![
                                                                        index]
                                                                    .description!,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelLarge!
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    case PostApiStatus.error:
                                                      print("Error");
                                                      return const Center(
                                                        child: Text(
                                                            "Error Occured"),
                                                      );
                                                    default:
                                                      return const SizedBox();
                                                  }
                                                })
                                              ],
                                            );
                                          },
                                        )
                                      : BlocBuilder<GooglePlaceApiBloc,
                                          GooglePlaceApiState>(
                                          builder: (context, state) {
                                            return Padding(
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          state.selectedAddress,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18.sp),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          "Karachi",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                            );
                                          },
                                        ),
                                ],
                              )),
                        ),
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
                    )),
            showMapIcon
                ? const SizedBox()
                : Center(
                    child: Image.asset(
                      ImageString.mapIconImage,
                      width: 50,
                      height: 50,
                      color: const Color(0xff7fbefb),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
