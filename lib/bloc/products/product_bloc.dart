import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/data/response/response.dart';
import 'package:my_app/repository/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductApiRepository productApiRepository;
  ProductBloc({required this.productApiRepository})
      : super(ProductState(
            allProrducts: ApiResponse.loading(),
            searchProrducts: ApiResponse.initial())) {
    on<GetAllProducts>(_getAllProducts);
    on<ProductImagePageChanged>(_productImagePageChanged);
    on<SearchProductAccordingToTitle>(_searchProductAccordingToTitle);
    on<ClearSearchProduct>(_clearSearchProduct);
  }

  _getAllProducts(GetAllProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(allProrducts: ApiResponse.loading()));

    await productApiRepository.getAllProducts(event.category).then((value) {
      emit(state.copyWith(allProrducts: ApiResponse.complete(value)));
    }).onError((error, _) {
      emit(state.copyWith(allProrducts: ApiResponse.error(error.toString())));
    });
  }

  _productImagePageChanged(
      ProductImagePageChanged event, Emitter<ProductState> emit) async {
    emit(state.copyWith(currentIndex: event.currentIndex));
  }

  _searchProductAccordingToTitle(
      SearchProductAccordingToTitle event, Emitter<ProductState> emit) async {
    // if (event.title.isEmpty) {
    //   emit(state.copyWith(
    //       searchProrducts: ApiResponse.complete(ProductModel(data: []))));

    //   return; // Exit early if no search term is provided
    // }
    emit(state.copyWith(searchProrducts: ApiResponse.loading()));
    await productApiRepository
        .getAllProductsAccordingTitle(event.title)
        .then((value) {
      emit(state.copyWith(searchProrducts: ApiResponse.complete(value)));
    }).onError((error, _) {
      emit(
          state.copyWith(searchProrducts: ApiResponse.error(error.toString())));
    });
  }

  _clearSearchProduct(
      ClearSearchProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(
        searchProrducts: ApiResponse.complete(ProductModel(data: []))));
  }
}
