import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeroori_customer/bloc/notification_bloc/notification_event.dart';
import 'package:zeroori_customer/bloc/notification_bloc/notification_state.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/services/notification_service.dart';

class NotificationListBloc
    extends Bloc<NotificationListEvent, NotificationListState> {
  NotificationListBloc();

  @override
  NotificationListState get initialState => Empty();

  @override
  Stream<NotificationListState> mapEventToState(
    NotificationListEvent event,
  ) async* {
    yield Loading();
    if (event is GetNotifications) {
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        int userId = preferences.getInt(SharedResources.USER_ID);
        final List notifications =
            await NotificationService.getNotifications(userId);

        if (notifications.length > 0) {
          yield Loaded(notifications);
        } else {
          yield Empty();
        }
      } catch (ex) {
        yield Error(ex.toString());
      }
    }
  }
}
