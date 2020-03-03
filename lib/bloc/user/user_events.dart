import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LogIn extends UserEvent{
  final int id;
  final String userJson;


  LogIn(this.id,this.userJson);

  @override
  List<Object> get props => [id,userJson];
}

class UserChanged extends UserEvent{
  final int id;
  final String userJson;


  UserChanged(this.id,this.userJson);

  @override
  List<Object> get props => [id,userJson];
}


class LogOut extends UserEvent{

  LogOut();

  @override
  List<Object> get props => [];
}

class AppInitial extends UserEvent{

  AppInitial();

  @override
  List<Object> get props => [];
}