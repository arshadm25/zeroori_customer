import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/connectivity/connectivity_bloc.dart';
import 'package:zeroori_customer/bloc/connectivity/connectivity_events.dart';
import 'package:zeroori_customer/pages/my_profile.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/utils/connection_helper.dart';

class BasePage extends StatefulWidget {
  final Widget child;
  final String title;
  final bool hasBack;
  final Widget trailing;
  final Widget floatingActionButton;
  final Widget bottomNavigationBar;
  final Widget customTitle;
  final Widget bottomSheet;

  const BasePage({Key key, this.title, this.hasBack:false, this.child,this.trailing,this.floatingActionButton,this.bottomNavigationBar,this.customTitle,this.bottomSheet})
      : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  ConnectivityBloc connectivityBloc;
  StreamSubscription<ConnectivityResult> subscription;


  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((result)=>ConnectionHelper.onConnectivityChanged(result,connectivityBloc));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    connectivityBloc = BlocProvider.of<ConnectivityBloc>(context);
    connectivityBloc.add(ConnectionChanged(true));
  }

  @override
  void dispose(){
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.secondaryColor,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          onPressed: widget.hasBack?() {
            Navigator.pop(context);
          }:(){
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=>MyProfilePage()
            ));
          },
          icon: Icon(
            widget.hasBack?Icons.arrow_back:Icons.menu,
            color: Colors.white,

          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          widget.trailing??Container(width: 0,height: 0,)
        ],
        backgroundColor: ColorResources.primaryColor,
        title: widget.customTitle??Text(widget.title.toUpperCase()),
      ),
      body: SafeArea(
        child: widget.child,
      ),
      floatingActionButton:widget.floatingActionButton??Container(width: 0,height: 0,) ,
      bottomNavigationBar: widget.bottomNavigationBar??Container(width: 0,height: 0,),
      bottomSheet: widget.bottomSheet??Container(width: 0,height: 0,),
    );
  }
}
