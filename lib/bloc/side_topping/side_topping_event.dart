import 'package:equatable/equatable.dart';
import 'package:my_app/model/side_toppings.dart';

abstract class SideToppingEvent extends Equatable {
  const SideToppingEvent();

  @override
  List<Object> get props => [];
}

class FetchAllSideTopping extends SideToppingEvent {}

class AddSideToppingEvent extends SideToppingEvent {
  final SideToppins sideToppins;
  const AddSideToppingEvent(this.sideToppins);
}

class GetTotalPrice extends SideToppingEvent {}


class ClearSideToppins extends SideToppingEvent{}