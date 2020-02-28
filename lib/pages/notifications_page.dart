import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/notification_bloc/bloc.dart';
import 'package:zeroori_customer/models/notifications.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/widgets/notification_widget.dart';

class NotificationsPage extends StatefulWidget{

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
      title: "Notifications",
      child: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<NotificationListBloc,NotificationListState>(
            builder: (context,state){
              if(state is Loading){
                return Container(
                  child:Center(
                    child:CircularProgressIndicator()
                  )
                );
              }
              if(state is Loaded){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: state.notifications.map((Notifications n)=>NotificationWidget(notification: n,)).toList(),
                );
              }
              if(state is Error){
                return Container(
                  child: Center(
                      child:Text(state.message)
                  ),
                );
              }
              return Container(
                child: Center(
                  child:Text("There are no notificaitons for now")
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}