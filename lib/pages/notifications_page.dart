import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/models/notifications.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/services/notification_service.dart';
import 'package:zeroori_customer/widgets/notification_widget.dart';

class NotificationsPage extends StatefulWidget{

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Notifications> notifications;


  @override
  void initState() {
    super.initState();
    //ToDo:change userid
    notifications = NotificationService.getNotifications(0);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      hasBack: true,
      title: "Notifications",
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: notifications.map((Notifications n)=>NotificationWidget(notification: n,)).toList(),
          ),
        ),
      ),
    );
  }
}