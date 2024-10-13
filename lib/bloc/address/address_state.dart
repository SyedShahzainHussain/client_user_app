import 'package:equatable/equatable.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/model/address_model.dart';

class AddressState extends Equatable {
  final PostApiStatus postApiStatus;
  final List<AddressModel> addressList;
  final AddressModel? selectedAddress;

  const AddressState(
      {this.addressList = const [],
      required this.postApiStatus,
      this.selectedAddress});

  AddressState copyWith(
      {PostApiStatus? postApiStatus,
      List<AddressModel>? addressList,
      AddressModel? selectedAddress}) {
    return AddressState(
        postApiStatus: postApiStatus ?? this.postApiStatus,
        addressList: addressList ?? this.addressList,
        selectedAddress: selectedAddress ?? this.selectedAddress);
  }

  @override
  List<Object?> get props => [postApiStatus, addressList, selectedAddress];
}
