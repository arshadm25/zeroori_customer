import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';

import 'connectivity_events.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc();

  @override
  ConnectivityState get initialState => HasConnection();

  @override
  Stream<ConnectivityState> mapEventToState(
    ConnectivityEvent event,
  ) async* {
    yield HasConnection();
    if (event is ConnectionChanged) {
      if (event.status) {
        yield HasConnection();
      } else {
        yield NoConnection();
      }
    }
  }
}
