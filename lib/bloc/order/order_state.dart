part of 'order_bloc.dart';
class OrderState extends Equatable {
  final PostApiStatus postApiStatus;

  const OrderState({required this.postApiStatus});


  OrderState copyWith({PostApiStatus? postApiStatus}){
    return OrderState(postApiStatus: postApiStatus??this.postApiStatus);
  }


  @override
  List<Object?> get props => [postApiStatus];

}