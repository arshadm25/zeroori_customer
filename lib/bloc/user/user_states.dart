import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class AppInitialState extends UserState {
  @override
  List<Object> get props => [];
}

class LoggedInState extends UserState{
  final bool isLoggedIn;
  final String user;
  final int userId;

  LoggedInState(this.isLoggedIn,this.user,this.userId);

  @override
  List<Object> get props => [isLoggedIn,user,userId];

}

class LoggedOutState extends UserState{

  LoggedOutState();

  @override
  List<Object> get props => [];
}
