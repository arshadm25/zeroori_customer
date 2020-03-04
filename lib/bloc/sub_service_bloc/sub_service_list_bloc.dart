import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:zeroori_customer/bloc/sub_service_bloc/sub_service_list_event.dart';
import 'package:zeroori_customer/bloc/sub_service_bloc/sub_service_list_state.dart';
import 'package:zeroori_customer/services/category_services.dart';

class SubServiceListBloc
    extends Bloc<SubServiceListEvent, SubServiceListState> {
  SubServiceListBloc();

  @override
  SubServiceListState get initialState => Empty();

  @override
  Stream<SubServiceListState> mapEventToState(
    SubServiceListEvent event,
  ) async* {
    yield Loading();
    if (event is GetServices) {
      try {
        final List services = await CategoryServices.getSubServices(event.id);
        if (services.length > 0) {
          yield Loaded(services);
        } else {
          yield Empty();
        }
      } catch (ex) {
        yield Error(ex.toString());
      }
    }
  }
}
