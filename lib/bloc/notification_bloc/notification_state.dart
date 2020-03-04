import 'package:equatable/equatable.dart';
import 'package:zeroori_customer/models/notifications.dart';

abstract class NotificationListState extends Equatable {
  const NotificationListState();
}

class Empty extends NotificationListState {
  @override
  List<Object> get props => [];
}

class Loading extends NotificationListState {
  @override
  List<Object> get props => [];
}

class Loaded extends NotificationListState {
  final List<Notifications> notifications;

  Loaded(this.notifications);

  @override
  List<Object> get props => [notifications];
}

class Error extends NotificationListState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}
