import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/data/response/response.dart';
import 'package:my_app/model/brand_model.dart';
import 'package:my_app/repository/brand/brand_api_repository.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandApiRepository brandApiRepository;
  BrandBloc({required this.brandApiRepository})
      : super(BrandState(
          getAllBrand: ApiResponse.loading(),
          getAllBrandWithQuery: ApiResponse.initial(),
        )) {
    on<GetAllBrand>(_getAllBrand);
    on<GetAllBrandWithQuery>(_getAllBrandWithQuery);
  }

  _getAllBrand(BrandEvent event, Emitter<BrandState> emit) async {
    emit(state.copyWith(getAllBrand: ApiResponse.loading()));
    await brandApiRepository.getAllBrand().then((data) {
      emit(state.copyWith(getAllBrand: ApiResponse.complete(data)));
    }).onError((error, _) {
      emit(state.copyWith(getAllBrand: ApiResponse.error(error.toString())));
    });
  }

  _getAllBrandWithQuery(
      GetAllBrandWithQuery event, Emitter<BrandState> emit) async {
    emit(state.copyWith(getAllBrandWithQuery: ApiResponse.loading()));
    await brandApiRepository.getAllBrandWithQuery(event.query).then((data) {
      emit(state.copyWith(getAllBrandWithQuery: ApiResponse.complete(data)));
    }).onError((error, _) {
      emit(state.copyWith(
          getAllBrandWithQuery: ApiResponse.error(error.toString())));
    });
  }
}
