part of 'order_bloc.dart';

class OrderState extends Equatable {
  final PostApiStatus postApiStatus;
  final List<OrderModel> getOrderList;
  final String message;

  const OrderState({required this.postApiStatus, this.getOrderList = const [],this.message=""});

  OrderState copyWith(
      {PostApiStatus? postApiStatus, List<OrderModel>? getOrderList,String? message}) {
    return OrderState(
        postApiStatus: postApiStatus ?? this.postApiStatus,
        getOrderList: getOrderList ?? this.getOrderList,message: message??this.message);
  }

  @override
  List<Object?> get props => [postApiStatus, getOrderList,message];
}
