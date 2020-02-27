import 'package:equatable/equatable.dart';
import 'package:zeroori_customer/models/order.dart';

abstract class OrderListEvent extends Equatable {
  const OrderListEvent();
}

class GetOrders extends OrderListEvent{
  final int userId;
  final OrderStatus orderStatus;

  GetOrders(this.userId,this.orderStatus);

  @override
  List<Object> get props => [userId];
}
