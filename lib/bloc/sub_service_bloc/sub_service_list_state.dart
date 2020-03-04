import 'package:equatable/equatable.dart';
import 'package:zeroori_customer/models/sub_service.dart';

abstract class SubServiceListState extends Equatable {
  const SubServiceListState();
}

class Empty extends SubServiceListState {
  @override
  List<Object> get props => [];
}

class Loading extends SubServiceListState {
  @override
  List<Object> get props => [];
}

class Loaded extends SubServiceListState {
  final List<SubService> services;

  Loaded(this.services);

  @override
  List<Object> get props => [services];
}

class Error extends SubServiceListState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}
