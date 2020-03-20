import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/connectivity/connectivity_bloc.dart';
import 'package:zeroori_customer/bloc/connectivity/connectivity_events.dart';
import 'package:zeroori_customer/bloc/connectivity/connectivity_state.dart';
import 'package:zeroori_customer/bloc/user/bloc.dart';
import 'package:zeroori_customer/pages/my_profile.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/utils/connection_helper.dart';

import 'front_page.dart';

class BasePage extends StatefulWidget {
  final Widget child;
  final String title;
  final bool hasBack;
  final Widget trailing;
  final Widget floatingActionButton;
  final Widget bottomNavigationBar;
  final Widget customTitle;
  final Widget bottomSheet;

  const BasePage(
      {Key key,
      this.title,
      this.hasBack: false,
      this.child,
      this.trailing,
      this.floatingActionButton,
      this.bottomNavigationBar,
      this.customTitle,
      this.bottomSheet})
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
    subscription = Connectivity().onConnectivityChanged.listen((result) =>
        ConnectionHelper.onConnectivityChanged(result, connectivityBloc));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    connectivityBloc = BlocProvider.of<ConnectivityBloc>(context);
    connectivityBloc.add(ConnectionChanged(true));
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LoggedOutState) {
          return FrontPage();
        }
        return BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, state) {
            if (state is HasConnection) {
              return _generateBuild();
            }
            return _generateNoConnection();
          },
        );
      },
    );
  }
  _generateBuild(){
    return Scaffold(
      backgroundColor: ColorResources.secondaryColor,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          onPressed: widget.hasBack
              ? () {
            Navigator.pop(context);
          }
              : () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyProfilePage()));
          },
          icon: Icon(
            widget.hasBack ? Icons.arrow_back : Icons.menu,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          widget.trailing ??
              Container(
                width: 0,
                height: 0,
              )
        ],
        backgroundColor: ColorResources.primaryColor,
        title: widget.customTitle ?? Text(widget.title.toUpperCase()),
      ),
      body: SafeArea(
        child: widget.child,
      ),
      floatingActionButton: widget.floatingActionButton ??
          Container(
            width: 0,
            height: 0,
          ),
      bottomNavigationBar: widget.bottomNavigationBar ??
          Container(
            width: 0,
            height: 0,
          ),
      bottomSheet: widget.bottomSheet ??
          Container(
            width: 0,
            height: 0,
          ),
    );
  }

  _generateNoConnection() {
    return Scaffold(
      backgroundColor: ColorResources.secondaryColor,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          onPressed: widget.hasBack
              ? () {
            Navigator.pop(context);
          }
              : () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyProfilePage()));
          },
          icon: Icon(
            widget.hasBack ? Icons.arrow_back : Icons.menu,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorResources.primaryColor,
        title: Text(AppTranslations.of(context).text(StringResources.noInternet)),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                AppTranslations.of(context).text(StringResources.oops),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                AppTranslations.of(context).text(StringResources.noInternetConnection),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 75,
              width: MediaQuery.of(context).size.width - 75,
              child: RaisedButton(
                color: ColorResources.primaryColor,
                onPressed: () {},
                child: Text(
                  AppTranslations.of(context).text(StringResources.tryAgain).toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
