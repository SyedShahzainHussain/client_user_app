import 'package:equatable/equatable.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/model/address_model.dart';

class AddressState extends Equatable {
  final PostApiStatus postApiStatus;
  final List<AddressModel> addressList;
  final AddressModel? selectedAddress;
  final String message;

  const AddressState(
      {this.addressList = const [],
      required this.postApiStatus,
      this.selectedAddress,this.message="",});

  AddressState copyWith(
      {PostApiStatus? postApiStatus,
      List<AddressModel>? addressList,
      AddressModel? selectedAddress,String? message}) {
    return AddressState(
        postApiStatus: postApiStatus ?? this.postApiStatus,
        addressList: addressList ?? this.addressList,
        selectedAddress: selectedAddress ?? this.selectedAddress,message:message??this.message);
  }

  @override
  List<Object?> get props => [postApiStatus, addressList, selectedAddress,message];
}
