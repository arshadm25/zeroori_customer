import 'package:equatable/equatable.dart';

abstract class NotificationListEvent extends Equatable {
  const NotificationListEvent();
}

class GetNotifications extends NotificationListEvent {
  GetNotifications();

  @override
  List<Object> get props => [];
}
