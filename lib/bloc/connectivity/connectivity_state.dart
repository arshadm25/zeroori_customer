import 'package:equatable/equatable.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();
}

class NoConnection extends ConnectivityState {
  @override
  List<Object> get props => [];
}

class HasConnection extends ConnectivityState{

  @override
  List<Object> get props => [];

}