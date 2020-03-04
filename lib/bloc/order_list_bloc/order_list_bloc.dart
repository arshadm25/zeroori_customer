import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeroori_customer/bloc/order_list_bloc/order_list_event.dart';
import 'package:zeroori_customer/bloc/order_list_bloc/order_list_state.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
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
        SharedPreferences preferences = await SharedPreferences.getInstance();
        int userId = preferences.getInt(SharedResources.USER_ID);
        final List orders =
            await OrderService.getOrders(userId, event.orderStatus);

        if (orders.length > 0) {
          yield Loaded(orders);
        } else {
          yield Empty();
        }
      } catch (ex) {
        yield Error(ex.toString());
      }
    }
  }
}
