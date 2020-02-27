import 'package:equatable/equatable.dart';
import 'package:zeroori_customer/models/Service.dart';

abstract class ServiceListState extends Equatable {
  const ServiceListState();
}

class Empty extends ServiceListState {
  @override
  List<Object> get props => [];
}

class Loading extends ServiceListState{

  @override
  List<Object> get props => [];
}

class Loaded extends ServiceListState{
  final List<Service> services;

  Loaded(this.services);
  
  @override
  List<Object> get props => [services];
}

class Error extends ServiceListState{
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}