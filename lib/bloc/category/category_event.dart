part of "category_bloc.dart";

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCategory extends CategoryEvent {}

class SetCategoryAndTitleEvent extends CategoryEvent {
  final String category;
  final String title;
  SetCategoryAndTitleEvent({required this.category, required this.title});
}



class ClearCategoryValue extends CategoryEvent {}