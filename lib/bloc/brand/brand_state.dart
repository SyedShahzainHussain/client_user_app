part of 'brand_bloc.dart';

class BrandState extends Equatable {
  final ApiResponse<List<BrandModel>> getAllBrand;

  const BrandState({required this.getAllBrand});

  BrandState copyWith({ApiResponse<List<BrandModel>>? getAllBrand}) {
    return BrandState(getAllBrand: getAllBrand ?? this.getAllBrand);
  }

  @override
  List<Object> get props => [getAllBrand];
}
