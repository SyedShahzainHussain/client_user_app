part of 'google_place_api_bloc.dart';

abstract class GooglePlaceApiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchGooglePlaceApi extends GooglePlaceApiEvent {
  final String input;
  FetchGooglePlaceApi({required this.input});
}

class CreateSessionTokenEveryTime extends GooglePlaceApiEvent {
  CreateSessionTokenEveryTime();
}

class GetAddressFromLatLng extends GooglePlaceApiEvent {
  final double longitude, latitude;
  GetAddressFromLatLng({required this.longitude, required this.latitude});
}

class GetCurrentPosition extends GooglePlaceApiEvent {
  final bool getAddress;
  final BuildContext context;
  GetCurrentPosition({required this.context,this.getAddress=true});
}

class GetTheEditAddress extends GooglePlaceApiEvent {
  final String address;
  GetTheEditAddress({required this.address});
}
