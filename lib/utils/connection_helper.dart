import 'package:connectivity/connectivity.dart';
import 'package:zeroori_customer/bloc/connectivity/connectivity_bloc.dart';
import 'package:zeroori_customer/bloc/connectivity/connectivity_events.dart';

class ConnectionHelper {
  static onConnectivityChanged(
      ConnectivityResult result, ConnectivityBloc bloc) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        bloc.add(ConnectionChanged(true));
        break;
      case ConnectivityResult.none:
        bloc.add(ConnectionChanged(false));
        break;
      default:
        bloc.add(ConnectionChanged(false));
        break;
    }
  }
}
