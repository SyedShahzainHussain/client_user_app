part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetAllProducts extends ProductEvent {
  final String category;
  const GetAllProducts(this.category);
}

class ProductImagePageChanged extends ProductEvent {
  final int currentIndex;
  const ProductImagePageChanged(this.currentIndex);
}


class SearchProductAccordingToTitle extends ProductEvent{
  final String title;
  const SearchProductAccordingToTitle(this.title);
}

class ClearSearchProduct extends ProductEvent{
  const ClearSearchProduct();
}