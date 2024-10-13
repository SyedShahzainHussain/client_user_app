part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaceOrderEvent extends OrderEvent {
  final BuildContext context;
  PlaceOrderEvent({required this.context});
}

class DeleteCart extends OrderEvent {
  final BuildContext context;
  DeleteCart({required this.context});
}

class CashOnDelivery extends OrderEvent {
  final double amount;
  final String  address;
  final BuildContext context;
  CashOnDelivery({required this.context,required this.amount,required this.address});
}

class StripePayment extends OrderEvent {
    final BuildContext context;
  StripePayment({required this.context});
}
