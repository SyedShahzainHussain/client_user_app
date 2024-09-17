import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/data/response/response.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/repository/category/category_api_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryApiRepository categoryApiRepository;
  CategoryBloc({required this.categoryApiRepository})
      : super(CategoryState(categoryList: ApiResponse.loading())) {
    on<FetchCategory>(_fetchCategory);
    on<SetCategoryAndTitleEvent>(setCategoryAndTitleEvent);
    on<ClearCategoryValue>(clearCategoryValue);
  }

  _fetchCategory(CategoryEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(categoryList: ApiResponse.loading()));
    await categoryApiRepository.getCategories().then((value) {
      emit(state.copyWith(categoryList: ApiResponse.complete(value)));
    }).onError((error, _) {
      emit(state.copyWith(categoryList: ApiResponse.error(error.toString())));
    });
  }

  setCategoryAndTitleEvent(
      SetCategoryAndTitleEvent event, Emitter<CategoryState> emit) {
    emit(state.copyWith(category: event.category, title: event.title));
  }

  clearCategoryValue(ClearCategoryValue event, Emitter<CategoryState> emit) {
    emit(state.copyWith(category: "66e95724aa2cba5c9dfe1afa", title: "all"));
  }
}
