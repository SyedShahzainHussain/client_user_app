import 'package:bloc/bloc.dart';
import 'package:my_app/bloc/side_topping/side_topping_event.dart';
import 'package:my_app/bloc/side_topping/side_topping_state.dart';
import 'package:my_app/data/response/response.dart';
import 'package:my_app/model/side_toppings.dart';
import 'package:my_app/repository/side_topping/side_topping_api_repository.dart';

class SideToppingBloc extends Bloc<SideToppingEvent, SideToppingState> {
  final SideToppingApiRepository sideToppingApiRepository;
  SideToppingBloc({required this.sideToppingApiRepository})
      : super(SideToppingState(getAllSideToppings: ApiResponse.initial())) {
    on<FetchAllSideTopping>(_fetchAllSideTopping);
    on<AddSideToppingEvent>(_addSideToppingEvent);
    on<GetTotalPrice>(_getTotalPrice);
    on<ClearSideToppins>(_clearSideToppins);
  }

  _fetchAllSideTopping(
      FetchAllSideTopping event, Emitter<SideToppingState> emit) async {
    emit(state.copyWith(getAllSideToppings: ApiResponse.loading()));
    await sideToppingApiRepository.getAllSideToppings().then((value) {

      emit(state.copyWith(getAllSideToppings: ApiResponse.complete(value)));
    }).onError((error, _) {
      emit(state.copyWith(
          getAllSideToppings: ApiResponse.error(error.toString())));
    });
  }

  _addSideToppingEvent(
      AddSideToppingEvent event, Emitter<SideToppingState> emit) async {
    final selectedToppings = List<SideToppins>.from(state.selectedSideToppings);

    final existingToppingIndex = selectedToppings
        .indexWhere((data) => data.sId == event.sideToppins.sId);
    if (existingToppingIndex >= 0) {
      selectedToppings.removeAt(existingToppingIndex);
    } else {
      selectedToppings.add(event.sideToppins);
    }

    emit(state.copyWith(selectedSideToppings: selectedToppings));
  }

  _getTotalPrice(GetTotalPrice event, Emitter<SideToppingState> emit) async {
    double totalPrice = 0.0;
    for (var sideOptions in state.selectedSideToppings) {
      totalPrice += double.tryParse(sideOptions.price!.toString()) ?? 0.0;
    }
    emit(state.copyWith(totalPrice: totalPrice));
  }


_clearSideToppins(ClearSideToppins event,Emitter<SideToppingState> emit)async{
  emit(state.copyWith(selectedSideToppings: []));
}

}
