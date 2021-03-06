import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/area_selection_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';

class FillOrderPage extends StatelessWidget {
  final int service;
  final int subCategory;

  const FillOrderPage({Key key, this.service, this.subCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: AppTranslations.of(context).text(StringResources.fill_order),
      hasBack: true,
      trailing: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/chat_bubble.png",
              color: ColorResources.primaryColor,
              width: MediaQuery.of(context).size.width / 2,
              fit: BoxFit.contain,
            ),
            Text(
              AppTranslations.of(context).text(StringResources.we_will_ask_few_questions),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width - 75,
              child: RaisedButton(
                color: ColorResources.primaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AreaSelectionPage(
                                service: service,
                                subCategory: subCategory,
                              )));
                },
                child: Text(
                    AppTranslations.of(context).text(StringResources.get_started).toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
