import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';

class SelectLanguagePage extends StatefulWidget {
  @override
  _SelectLanguagePageState createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: "Select Language",
        hasBack: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _generateLanguageItem(
                ColorResources.primaryColor, "EN", Colors.white,
                onLanguageChange: () {
              //ToDo:implement on language change
            }),
            SizedBox(height: 25),
            _generateLanguageItem(
                Colors.white, "AR", ColorResources.primaryColor),
          ],
        ));
  }

  _generateLanguageItem(color, language, textColor,
      {VoidCallback onLanguageChange}) {
    return InkWell(
      onTap: onLanguageChange,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 5,
          height: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: ColorResources.primaryColor),
          ),
          child: Center(
              child: Text(
            language,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )),
        ),
      ),
    );
  }
}
