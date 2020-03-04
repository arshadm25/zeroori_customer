import 'package:equatable/equatable.dart';
import 'package:zeroori_customer/services/order_services.dart';

abstract class OrderListEvent extends Equatable {
  const OrderListEvent();
}

class GetOrders extends OrderListEvent {
  final OrderStatus orderStatus;

  GetOrders(this.orderStatus);

  @override
  List<Object> get props => [orderStatus];
}
