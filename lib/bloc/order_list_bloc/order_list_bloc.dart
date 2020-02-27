import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:zeroori_customer/bloc/order_list_bloc/order_list_event.dart';
import 'package:zeroori_customer/bloc/order_list_bloc/order_list_state.dart';
import 'package:zeroori_customer/services/order_services.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {

  OrderListBloc();

  @override
  OrderListState get initialState => Empty();

  @override
  Stream<OrderListState> mapEventToState(
      OrderListEvent event,
  ) async* {
    yield Loading();
    if (event is GetOrders) {
      try {
        final List orders = await OrderService.getOrders(event.userId,event.orderStatus);

        if(orders.length>0){
          yield Loaded(orders);
        }else{
          yield Empty();
        }
      } catch (ex){
        yield Error(ex.toString());
      }
    }
  }
}


