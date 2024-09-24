import 'package:equatable/equatable.dart';
import 'package:my_app/data/response/response.dart';
import 'package:my_app/model/side_toppings.dart';

class SideToppingState extends Equatable {
  final ApiResponse<List<SideToppins>> getAllSideToppings;
  final List<SideToppins> selectedSideToppings;
  final double totalPrice;

  const SideToppingState({
    required this.getAllSideToppings,
    this.selectedSideToppings = const [],
    this.totalPrice = 0.0,
  });

  SideToppingState copyWith(
      {ApiResponse<List<SideToppins>>? getAllSideToppings,
      List<SideToppins>? selectedSideToppings,
      double? totalPrice}) {
    return SideToppingState(
      getAllSideToppings: getAllSideToppings ?? this.getAllSideToppings,
      selectedSideToppings: selectedSideToppings ?? this.selectedSideToppings,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props =>
      [getAllSideToppings, selectedSideToppings, totalPrice];
}
