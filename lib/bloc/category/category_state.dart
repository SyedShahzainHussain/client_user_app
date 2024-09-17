part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final String category, title;
  final ApiResponse<List<CategoryModel>> categoryList;

  const CategoryState({
    required this.categoryList,
    this.category = "66e95724aa2cba5c9dfe1afa",
    this.title = "all",
  });

  CategoryState copyWith({
    ApiResponse<List<CategoryModel>>? categoryList,
    String? category,
    String? title,
  }) {
    return CategoryState(
        category: category ?? this.category,
        title: title ?? this.title,
        categoryList: categoryList ?? this.categoryList);
  }

  @override
  List<Object?> get props => [categoryList, category, title];
}
