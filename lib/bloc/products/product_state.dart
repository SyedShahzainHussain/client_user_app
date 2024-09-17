part of 'product_bloc.dart';

class ProductState extends Equatable {
  final ApiResponse<ProductModel> allProrducts;
  final int currentIndex;
  const ProductState({required this.allProrducts, this.currentIndex = 0});

  ProductState copyWith(
      {ApiResponse<ProductModel>? allProrducts, int? currentIndex}) {
    return ProductState(
        allProrducts: allProrducts ?? this.allProrducts,
        currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object> get props => [allProrducts, currentIndex];
}
