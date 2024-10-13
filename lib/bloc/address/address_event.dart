import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_app/model/address_model.dart';

abstract class AddressEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateAddress extends AddressEvent {
  final BuildContext context;
  CreateAddress({required this.context});
}

class GetAddress extends AddressEvent {
  GetAddress();
}

class DeleteAddress extends AddressEvent {
  final String id;
  DeleteAddress({required this.id });
}

class SelectAddress extends AddressEvent {
  final AddressModel selectedAddress;

  SelectAddress(this.selectedAddress);
}



