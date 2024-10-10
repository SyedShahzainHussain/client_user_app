part of 'google_place_api_bloc.dart';

class GooglePlaceApiState extends Equatable {
  final PostApiStatus postApiStatus;
  final DeleiveryAddressModel? predictions;
  final String sessionCode;
  final String selectedAddress;
  final Position? position;

  const GooglePlaceApiState({
    this.postApiStatus = PostApiStatus.initial,
    this.predictions,
    this.sessionCode = '1234567890',
    this.selectedAddress = "",
    this.position,
  });

  GooglePlaceApiState copyWith(
      {PostApiStatus? postApiStatus,
      DeleiveryAddressModel? predictions,
      String? sessionCode,
      String? selectedAddress,
      Position? position}) {
    return GooglePlaceApiState(
      postApiStatus: postApiStatus ?? this.postApiStatus,
      predictions: predictions ?? this.predictions,
      sessionCode: sessionCode ?? this.sessionCode,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      position: position ?? this.position,
    );
  }

  @override
  List<Object?> get props => [
        predictions,
        postApiStatus,
        sessionCode,
        selectedAddress,
        position,
      ];
}
