import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: AppTranslations.of(context).text(StringResources.aboutService),
        hasBack: true,
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Text(
            AppTranslations.of(context).text(StringResources.aboutContent),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorResources.primaryColor,
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
        )));
  }
}
