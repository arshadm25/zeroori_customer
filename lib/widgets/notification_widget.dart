import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/models/notifications.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';

class NotificationWidget extends StatelessWidget {
  final Notifications notification;

  const NotificationWidget({Key key, this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: Offset(5, 5),
                  color: Colors.grey.withOpacity(.5),
                  blurRadius: 5)
            ]),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width / 15,
                  height: MediaQuery.of(context).size.width / 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.primaryColor,
                  ),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      notification.notification,
                      maxLines: 5,
                      style: StyleResources.notificationContent(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      notification.notifiedOn,
                      style: StyleResources.notificationDate(),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
