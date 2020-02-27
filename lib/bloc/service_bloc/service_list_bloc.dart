import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:zeroori_customer/bloc/service_bloc/service_list_event.dart';
import 'package:zeroori_customer/bloc/service_bloc/service_list_state.dart';
import 'package:zeroori_customer/services/category_services.dart';

class ServiceListBloc extends Bloc<ServiceListEvent, ServiceListState> {

  ServiceListBloc();

  @override
  ServiceListState get initialState => Empty();

  @override
  Stream<ServiceListState> mapEventToState(
      ServiceListEvent event,
  ) async* {
    yield Loading();
    if (event is GetServices) {
      try {

        final List services = await CategoryServices.getServices();
        if(services.length>0){
          yield Loaded(services);
        }else{
          yield Empty();
        }
      } catch (ex){
        yield Error(ex.toString());
      }
    }
  }
}


