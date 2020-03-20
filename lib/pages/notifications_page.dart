import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/notification_bloc/bloc.dart';
import 'package:zeroori_customer/models/notifications.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/widgets/notification_widget.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Notifications> notifications;
  NotificationListBloc bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<NotificationListBloc>(context);
    bloc.add(GetNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      hasBack: true,
      title: AppTranslations.of(context).text(StringResources.notifications),
      child: SafeArea(
        child: BlocBuilder<NotificationListBloc, NotificationListState>(
          builder: (context, state) {
            if (state is Loading) {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            }
            if (state is Loaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: state.notifications
                    .map((Notifications n) => NotificationWidget(
                          notification: n,
                        ))
                    .toList(),
              );
            }
            if (state is Error) {
              return Container(
                child: Center(child: Text(state.message)),
              );
            }
            return Container(
              height: MediaQuery.of(context).size.height - 200,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Text(AppTranslations.of(context).text(StringResources.no_notifications),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
