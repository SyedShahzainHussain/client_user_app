import 'package:equatable/equatable.dart';

abstract class RatingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateRating extends RatingEvent {
  final String message;
  final double star;

  CreateRating({required this.message, required this.star});
}
