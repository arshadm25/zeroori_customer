import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/image_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.asset(ImageResources.logo),
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.width / 8,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
//                    icon: Icon(Icons.assignment,color: ColorResources.primaryColor,),
                    child: Text(
                      AppTranslations.of(context).text(StringResources.register).toUpperCase(),
                      style: StyleResources.secondaryButton(),
                    ),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.width / 8,
                  child: RaisedButton(
//                    icon: Icon(Icons.assignment,color: ColorResources.primaryColor,),
                    child: Text(
                      AppTranslations.of(context).text(StringResources.login).toUpperCase(),
                      style: StyleResources.secondaryButton(),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    color: Colors.white,
                  ),
                ),
//                SizedBox(
//                  height: 20,
//                ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      _generateIconTile("assets/whatsapp.png"),
//                      _generateIconTile("assets/instagram.png"),
//                      _generateIconTile("assets/fb.png"),
//                      _generateIconTile("assets/twitter.png"),
//                    ],
//                  ),
//                ),
                SizedBox(
                  height: 25,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _generateIconTile(String iconData) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          iconData,
          color: Colors.white,
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}
