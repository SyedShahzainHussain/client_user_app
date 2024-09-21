part of 'brand_bloc.dart';

sealed class BrandEvent extends Equatable {
  const BrandEvent();

  @override
  List<Object> get props => [];
}

class GetAllBrand extends BrandEvent {}


class GetAllBrandWithQuery extends BrandEvent{
  final String query;
  const GetAllBrandWithQuery(this.query);
}