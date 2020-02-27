import 'package:equatable/equatable.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();
}

class ConnectionChanged extends ConnectivityEvent{
  final bool status;

  ConnectionChanged(this.status);

  @override
  List<Object> get props => [status];
}