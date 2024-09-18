part of 'product_bloc.dart';

class ProductState extends Equatable {
  final ApiResponse<ProductModel> allProrducts;
  final ApiResponse<ProductModel> searchProrducts;
  final int currentIndex;
  const ProductState(
      {required this.allProrducts,
      required this.searchProrducts,
      this.currentIndex = 0});

  ProductState copyWith(
      {ApiResponse<ProductModel>? allProrducts,
      ApiResponse<ProductModel>? searchProrducts,
      int? currentIndex}) {
    return ProductState(
      allProrducts: allProrducts ?? this.allProrducts,
      currentIndex: currentIndex ?? this.currentIndex,
      searchProrducts: searchProrducts ?? this.searchProrducts,
    );
  }

  @override
  List<Object> get props => [allProrducts, currentIndex, searchProrducts];
}
