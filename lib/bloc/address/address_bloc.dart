import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:my_app/bloc/address/address_event.dart';
import 'package:my_app/bloc/address/address_state.dart';
import 'package:my_app/bloc/google_place_api/google_place_api_bloc.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/repository/address/address_repository.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressHttpRepository;
  AddressBloc({required this.addressHttpRepository})
      : super(const AddressState(postApiStatus: PostApiStatus.initial)) {
    on<CreateAddress>(_createAddress);
    on<GetAddress>(_getAddress);
    on<DeleteAddress>(_deleteAddress);
    on<SelectAddress>(_selectedAddress);
  }

  _createAddress(CreateAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    final selectedAddress =
        event.context.read<GooglePlaceApiBloc>().state.selectedAddress;

    List<Location> locations = await locationFromAddress(selectedAddress);

    final double latitude = locations[0].latitude;
    final double longitude = locations[0].longitude;
    final body = {
      "address": selectedAddress,
      "latitude": latitude,
      "longitude": longitude,
    };
    await addressHttpRepository.addAddress(body).then((value) {
      emit(state.copyWith(postApiStatus: PostApiStatus.success));
    }).onError((error, _) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    });
  }

  _getAddress(GetAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading,message: ""));
    await addressHttpRepository.getAddressList().then((value) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.success, addressList: value));
    }).onError((error, _) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error,message: error.toString()));
    });
  }

  _deleteAddress(DeleteAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    await addressHttpRepository.deleteAddress(event.id).then((_) {
      emit(state.copyWith(postApiStatus: PostApiStatus.success));
    }).onError((error, _) {});
  }

  _selectedAddress(SelectAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(selectedAddress: event.selectedAddress));
  }
}
