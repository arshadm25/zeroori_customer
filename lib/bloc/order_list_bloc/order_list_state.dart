import 'package:equatable/equatable.dart';
import 'package:zeroori_customer/models/order.dart';

abstract class OrderListState extends Equatable {
  const OrderListState();
}

class Empty extends OrderListState {
  @override
  List<Object> get props => [];
}

class Loading extends OrderListState {
  @override
  List<Object> get props => [];
}

class Loaded extends OrderListState {
  final List<Order> orders;

  Loaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class Error extends OrderListState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}
