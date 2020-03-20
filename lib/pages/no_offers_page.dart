import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';

import 'BasePage.dart';

class NoOffersPage extends StatefulWidget {
  @override
  _NoOffersPageState createState() => _NoOffersPageState();
}

class _NoOffersPageState extends State<NoOffersPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BasePage(
        hasBack: true,
        title: AppTranslations.of(context).text(StringResources.no_offers),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: ColorResources.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                    labelColor: ColorResources.primaryColor,
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25 / 2)),
                    ),
                    tabs: <Widget>[
                      _generateTabBarTextItem("All Offers"),
                      _generateTabBarTextItem("Favourites"),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 100,
                child: TabBarView(
                  children: <Widget>[
                    _generateNoOfferPage(),
                    _generateNoOfferPage(),
                  ],
                ),
              )
            ],
          ),
        )),
//        floatingActionButton: FloatingActionButton(
//          onPressed: (){
//            Navigator.pushNamed(context, '')
//          },
//          backgroundColor: ColorResources.floatingActionButtonColor,
//          child: Icon(Icons.chat_bubble),
//        ),
      ),
    );
  }

  _generateNoOfferPage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
            child: Icon(
          Icons.comment,
          size: 50,
          color: ColorResources.primaryColor,
        )),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "No Offers Selected",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "Favourite Offers you like to compare it later to select the best one",
            textAlign: TextAlign.center,
            maxLines: 3,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }

  _generateTabBarTextItem(text) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: 25,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
