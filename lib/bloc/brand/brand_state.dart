part of 'brand_bloc.dart';

class BrandState extends Equatable {
  final ApiResponse<List<BrandModel>> getAllBrand;
  final ApiResponse<List<BrandModel>> getAllBrandWithQuery;

  const BrandState({required this.getAllBrand,required this.getAllBrandWithQuery});

  BrandState copyWith({ApiResponse<List<BrandModel>>? getAllBrand,ApiResponse<List<BrandModel>>? getAllBrandWithQuery}) {
    return BrandState(getAllBrand: getAllBrand ?? this.getAllBrand,getAllBrandWithQuery:getAllBrandWithQuery??this.getAllBrandWithQuery);
  }

  @override
  List<Object> get props => [getAllBrand,getAllBrandWithQuery];
}
