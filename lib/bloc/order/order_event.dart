
part of 'order_bloc.dart';

abstract class  OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class PlaceOrderEvent extends OrderEvent{
  final BuildContext context;
   PlaceOrderEvent({required this.context});
}


class DeleteCart extends OrderEvent{
    final BuildContext context;
  DeleteCart({required this.context});
}