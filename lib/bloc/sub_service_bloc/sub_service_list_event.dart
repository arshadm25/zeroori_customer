import 'package:equatable/equatable.dart';

abstract class SubServiceListEvent extends Equatable {
  const SubServiceListEvent();
}

class GetServices extends SubServiceListEvent{
  final int id;

  GetServices(this.id);

  @override
  List<Object> get props => [id];
}
