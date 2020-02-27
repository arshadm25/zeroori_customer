import 'package:equatable/equatable.dart';

abstract class ServiceListEvent extends Equatable {
  const ServiceListEvent();
}

class GetServices extends ServiceListEvent{


  GetServices();

  @override
  List<Object> get props => [];
}
