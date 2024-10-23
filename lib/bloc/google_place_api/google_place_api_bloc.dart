import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/model/delivery_address_model.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:my_app/repository/google_place_repository/google_place_http_repository.dart';

part 'google_place_api_event.dart';
part 'google_place_api_state.dart';

class GooglePlaceApiBloc
    extends Bloc<GooglePlaceApiEvent, GooglePlaceApiState> {
  final GooglePlaceApiHttpRepository googlePlaceApiRepository;

  GooglePlaceApiBloc({required this.googlePlaceApiRepository})
      : super(const GooglePlaceApiState()) {
    on<FetchGooglePlaceApi>(_fetchGooglePlaceApi);
    on<CreateSessionTokenEveryTime>(_createSessionTokenEveryTime);
    on<GetAddressFromLatLng>(_getAddressFromLatLng);
    on<GetCurrentPosition>(_getCurrentPosition);
    on<GetTheEditAddress>(_getTheEditAddress);
  }

  _fetchGooglePlaceApi(
      FetchGooglePlaceApi event, Emitter<GooglePlaceApiState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    await googlePlaceApiRepository
        .getAddressDescription(event.input, state.sessionCode)
        .then((data) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.success, predictions: data));
    }).onError((error, _) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    });
  }

  _createSessionTokenEveryTime(CreateSessionTokenEveryTime event,
      Emitter<GooglePlaceApiState> emit) async {
    String sessionToken = state.sessionCode;
    sessionToken = Random(12222322).toString();

    emit(state.copyWith(sessionCode: sessionToken));
  }

  _getAddressFromLatLng(
      GetAddressFromLatLng event, Emitter<GooglePlaceApiState> emit) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(event.latitude, event.longitude);
      if (placemarks.isNotEmpty) {
        var address = '';

        if (placemarks.isNotEmpty) {
          // Concatenate non-null components of the address
          var streets = placemarks.reversed
              .map((placemark) => placemark.street)
              .where((street) => street != null);

          // Filter out unwanted parts
          streets = streets.where((street) =>
              street!.toLowerCase() !=
              placemarks.reversed.last.locality!
                  .toLowerCase()); // Remove city names
          streets = streets
              .where((street) => !street!.contains('+')); // Remove street codes

          address += streets.join(', ');

          address += ', ${placemarks.reversed.last.subLocality ?? ''}';
          address += ', ${placemarks.reversed.last.locality ?? ''}';
          address +=
              ', ${placemarks.reversed.last.subAdministrativeArea ?? ''}';
          address += ', ${placemarks.reversed.last.administrativeArea ?? ''}';
          address += ', ${placemarks.reversed.last.postalCode ?? ''}';
          address += ', ${placemarks.reversed.last.country ?? ''}';
        }
        emit(state.copyWith(selectedAddress: address));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching address: $e');
      }
    }
  }

  _getCurrentPosition(
      GetCurrentPosition event, Emitter<GooglePlaceApiState> emit) async {
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
    if (event.context.mounted&&event.getAddress) {
      event.context.read<GooglePlaceApiBloc>().add(GetAddressFromLatLng(
          longitude: position.longitude, latitude: position.latitude));
    }
    emit(state.copyWith(position: position));
  }

  _getTheEditAddress(
      GetTheEditAddress event, Emitter<GooglePlaceApiState> emit) async {
    emit(state.copyWith(selectedAddress: event.address));
  }
}
